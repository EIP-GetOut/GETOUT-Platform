/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type UUID } from 'node:crypto'

import { AccountDoesNotExistError, AppError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

async function getAccountsCreatedPastWeek (): Promise<number> {
  const accountRepository = appDataSource.getRepository(Account)

  const oneWeekAgo = new Date()
  oneWeekAgo.setDate(oneWeekAgo.getDate() - 7)

  const count = await accountRepository
    .createQueryBuilder('account')
    .where('account.createdDate >= :oneWeekAgo', { oneWeekAgo })
    .getCount()

  return count
}

async function getAccounts (page: number): Promise<any> {
  return await appDataSource.getRepository(Account).find({ take: 50, skip: (page - 1) * 50, relations: ['role'] }).then(async (accounts: Account []) => {
    return {
      list: accounts,
      accountCreatedLastWeek: await getAccountsCreatedPastWeek()
    }
  }).catch((err: AppError | Error) => {
    if (err instanceof AppError) {
      throw err
    } else {
      throw new AppError()
    }
  })
}

async function deleteAccountById (uuid: UUID): Promise<void> {
  const accountRepository = appDataSource.getRepository(Account)
  await findEntity<Account>(Account, { id: uuid }).then(async (foundAccount: Account | null) => {
    if (foundAccount == null) {
      throw new AccountDoesNotExistError()
    }
    return await accountRepository.delete(uuid as string)
  })
}
export { deleteAccountById, getAccounts }
