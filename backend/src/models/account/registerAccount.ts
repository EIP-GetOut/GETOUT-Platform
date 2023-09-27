/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import bcrypt from 'bcrypt'

import logger from '@middlewares/logging'

import { AccountAlreadyExistError, BcryptError, DbError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { type accountRepositoryRequest } from './account'

async function createNewAccountObject (account: accountRepositoryRequest): Promise<accountRepositoryRequest> {
  let bornDate: Date = account.bornDate
  let saltPassword

  return await bcrypt.genSalt().then(async (salt: string) => {
    saltPassword = salt
    return await bcrypt.hash(account.password + salt, 10)
  }).then((hash: string) => {
    if (bornDate != null) {
      const date = bornDate.toString().split('/')
      bornDate = new Date(parseInt(date[2]), parseInt(date[1]) - 1, parseInt(date[0]))
    }
    return ({
      salt: saltPassword,
      email: account.email,
      password: hash,
      firstName: account.firstName,
      lastName: account.lastName,
      bornDate
    })
  }).catch((err: Error) => {
    throw new BcryptError(err.message)
  })
}

async function registerAccount (account: accountRepositoryRequest): Promise<Account> {
  const accountRepository = appDataSource.getRepository(Account)

  return await findEntity<Account>(Account, { email: account.email }).then((foundAccount: Account | null): any => {
    if (foundAccount !== null) {
      throw new AccountAlreadyExistError()
    }
    return createNewAccountObject(account).then(async (newAccount: accountRepositoryRequest) => {
      return await accountRepository.save(newAccount).then((savedAccount: accountRepositoryRequest & Account) => {
        logger.info(`Account has been created: ${JSON.stringify(savedAccount, null, 2)}`)
        return savedAccount
      }).catch((err: Error) => {
        throw new DbError(err.message)
      })
    })
  })
}

export default registerAccount
