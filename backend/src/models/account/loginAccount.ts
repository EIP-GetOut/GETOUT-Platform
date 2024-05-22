/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import bcrypt from 'bcrypt'
import { type Session, type SessionData } from 'express-session'
import { StatusCodes } from 'http-status-codes'

import { authentifyWithGoogle } from '@services/authentification'
import { AccountDoesNotExistError, ApiError, AppError, BcryptError, IncorrectEmailOrPasswordError } from '@services/utils/customErrors'
import calculateSpentMinutesReadingAndWatching from '@services/utils/spentTimeCalculation'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { type oauthAccount } from '@routes/account/oauth/oauthAccount'

import { type accountRepositoryRequest } from './account'

async function createSession (sess: Session & Partial<SessionData>, account: Account): Promise<void> {
  const week = 3600000 * 24 * 7

  sess.cookie.expires = new Date(Date.now() + week)
  sess.cookie.maxAge = week

  const sessAccount: any = { ...account }
  delete sessAccount.password
  delete sessAccount.salt
  delete sessAccount.passwordResetCode
  delete sessAccount.passwordResetExpiration
  sessAccount.spentMinutesReadingAndWatching = 0
  sess.account = sessAccount

  await calculateSpentMinutesReadingAndWatching(sess.account!).then((spentMinutes: number) => {
    sess.account!.spentMinutesReadingAndWatching = spentMinutes
  }).catch((err: Error) => {
    throw new ApiError(`Failed calculating spent time reading and watching (${err.name}: ${err.message}).`)
  })
}

async function loginWithGoogle (account: oauthAccount, sess: Session): Promise<StatusCodes> {
  return await authentifyWithGoogle(account).then(([isOk]) => {
    if (isOk) {
    //   createSession(sess, account)
      return StatusCodes.OK
    }
    return StatusCodes.FORBIDDEN
  }).catch((err) => {
    throw new Error(err)
  })
}

async function loginAccount (accountToLogin: accountRepositoryRequest, sess: Session): Promise<void> {
  await findEntity<Account>(Account, { email: accountToLogin.email }).then(async (foundAccount: Account | null) => {
    if (foundAccount == null) {
      throw new AccountDoesNotExistError()
    }
    await bcrypt.compare(accountToLogin.password + foundAccount.salt, foundAccount.password).then(async (comparison: boolean) => {
      if (!comparison) {
        throw new IncorrectEmailOrPasswordError(`Account's email or password is incorrect: ${accountToLogin.email}`)
      }
      await createSession(sess, foundAccount)
    }).catch((err: AppError | Error) => {
      if (err instanceof AppError) {
        throw err
      } else {
        throw new BcryptError(err.message)
      }
    })
  })
}

export { loginAccount, loginWithGoogle }
