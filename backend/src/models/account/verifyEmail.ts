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

function getDateIn1Day (): Date {
  const current = new Date()
  const followingDay = new Date(current.getTime() + (24 * 3000000)) // + 24 hour in ms

  return followingDay
}

async function generateEmailVerificationCode (email: string): Promise<number> {
  return await findEntity<Account>(Account, { email }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    account.emailVerificationCode = process.env.NODE_ENV === 'development' || process.env.NODE_ENV === 'test'
      ? 123456
      : Math.floor(100000 + Math.random() * 900000)
    account.emailVerificationExpiration = getDateIn1Day()
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
      account.emailVerificationExpiration != null &&
      Date.now() < new Date(account.emailVerificationExpiration).getTime()
    )
  })
}

async function verifyEmail (accountId: UUID): Promise<void> {
  const accountRepository = appDataSource.getRepository(Account)

  await findEntity<Account>(Account, { id: accountId }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    account.isVerified = true
    await accountRepository.save(account)
  })
}

export {
  accountIsAllowedToVerifyEmail,
  generateEmailVerificationCode,
  verifyEmail
}
