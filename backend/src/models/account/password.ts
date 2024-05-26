/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import bcrypt from 'bcrypt'
import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'

import { AccountDoesNotExistError, AuthenticationError, DbError, SamePasswordError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

function getDateIn1Hour (): Date {
  const current = new Date()
  const followingDay = new Date(current.getTime() + 3000000) // + 1 hour in ms

  return followingDay
}

async function generatePasswordResetCode (email: string): Promise<number> {
  return await findEntity<Account>(Account, { email }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    account.passwordResetCode = process.env.NODE_ENV === 'development'
      ? 123456
      : Math.floor(100000 + Math.random() * 900000)
    account.passwordResetExpiration = getDateIn1Hour()
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((account: Account) => {
    if (account?.passwordResetCode == null) {
      throw new DbError('Failed generating password reset code.')
    }
    return account.passwordResetCode
  })
}

async function accountIsAllowedToResetPassword (code: number): Promise<boolean> {
  return await findEntity<Account>(Account, { passwordResetCode: code }).then((account: Account | null) => {
    return (
      account != null &&
      code === account.passwordResetCode &&
      account.passwordResetExpiration != null &&
      Date.now() < new Date(account.passwordResetExpiration).getTime()
    )
  })
}

async function changeAccountPassword (accountId: UUID, oldPassword: string, newPassword: string): Promise<void> {
  let foundAccount: Account

  await findEntity<Account>(Account, { id: accountId }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    foundAccount = account
    return await bcrypt.compare(oldPassword + account.salt, account.password)
  }).then(async (passwordsDoesMatch: boolean) => {
    if (!passwordsDoesMatch) {
      throw new AuthenticationError('Password is invalid.')
    }
    return await bcrypt.hash(newPassword + foundAccount.salt, 10)
  }).then(async (hash: string) => {
    foundAccount.password = hash
    await appDataSource.getRepository<Account>('Account').save(foundAccount).then((account: Account | null) => {
      if (account == null) {
        throw new DbError('Failed modifying the password.')
      }
    })
  })
}

async function changeAccountPasswordFromCode (code: number, newPassword: string): Promise<Account> {
  let foundAccount: Account

  return await findEntity<Account>(Account, { passwordResetCode: code }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    foundAccount = account
    return await bcrypt.compare(newPassword + account.salt, account.password)
  }).then(async (isSamePassword: boolean) => {
    if (isSamePassword) {
      throw new SamePasswordError()
    }
    return await bcrypt.genSalt()
  }).then(async (salt: string) => {
    foundAccount.salt = salt
    return await bcrypt.hash(newPassword + salt, 10)
  }).then(async (password) => {
    foundAccount.password = password
    foundAccount.passwordResetCode = null
    foundAccount.passwordResetExpiration = null
    return await appDataSource.getRepository<Account>('Account').save(foundAccount)
  }).then((account: Account | null) => {
    if (account == null) {
      throw new DbError('Failed modifying the password.')
    }
    return account
  })
}

export {
  accountIsAllowedToResetPassword,
  changeAccountPassword,
  changeAccountPasswordFromCode,
  generatePasswordResetCode
}
