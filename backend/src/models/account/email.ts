/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'

import { sendEmailVerificationEmail } from '@services/brevo/emails'
import logger from '@services/middlewares/logging'
import { AccountDoesNotExistError, DbError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { generateEmailVerificationCode } from './verifyEmail'

async function changeAccountEmail (accountId: UUID, newEmail: string): Promise<void> {
  await findEntity<Account>(Account, { id: accountId }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    account.newEmail = newEmail
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then(async (account: Account | null) => {
    if (account == null) {
      throw new DbError('Failed modifying the new email.')
    }
    return await generateEmailVerificationCode(account.email).then(async (code) => {
      logger.debug(`Sending email verification code to new email ${account.newEmail} : ${code}.`)
      return await sendEmailVerificationEmail(account, code, true)
    })
  })
}

async function verifyNewEmail (accountId: UUID): Promise<void> {
  await findEntity<Account>(Account, { id: accountId }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    account.email = account.newEmail!
    account.newEmail = null
    return await appDataSource.getRepository<Account>('Account').save(account)
  })
}

export { changeAccountEmail, verifyNewEmail }
