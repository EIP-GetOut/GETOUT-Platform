/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'

import { AccountDoesNotExistError, DbError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

function getDateIn1Hour (): Date {
  const current = new Date()
  const followingDay = new Date(current.getTime() + 3000000) // + 1 hour in ms

  return followingDay
}

async function generateEmailVerificationCode (email: string): Promise<number> {
  return await findEntity<Account>(Account, { email }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    account.emailVerificationCode = process.env.NODE_ENV === 'development'
      ? 123456
      : Math.floor(100000 + Math.random() * 900000)
    account.emailVerificationExpiration = getDateIn1Hour()
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((account: Account) => {
    if (account?.emailVerificationCode == null) {
      throw new DbError('Failed generating verify email code.')
    }
    return account.emailVerificationCode
  })
}

async function accountIsAllowedToVerifyEmail (accountId: UUID, code: number): Promise<boolean> {
  return await findEntity<Account>(Account, { id: accountId }).then((account: Account | null) => {
    return (
      account != null &&
      code === account.emailVerificationCode &&
      account.passwordResetExpiration != null &&
      Date.now() < new Date(account.passwordResetExpiration).getTime()
    )
  })
}

async function verifyEmail (accountId: UUID): Promise<void> {
  await findEntity<Account>(Account, { id: accountId }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    account.isVerified = true
  })
}

export {
  accountIsAllowedToVerifyEmail,
  generateEmailVerificationCode,
  verifyEmail
}
