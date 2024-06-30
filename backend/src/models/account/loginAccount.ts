/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import bcrypt from 'bcrypt'
import { type Request } from 'express'
import { StatusCodes } from 'http-status-codes'

import { authentifyWithGoogle } from '@services/authentification'
import { AccountDoesNotExistError, ApiError, AppError, BcryptError, IncorrectEmailOrPasswordError } from '@services/utils/customErrors'
import calculateSpentMinutesReadingAndWatching from '@services/utils/spentTimeCalculation'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { type oauthAccount } from '@routes/account/oauth/oauthAccount'

import { type accountRepositoryRequest } from './account'

async function createSession (req: Request, account: Account): Promise<void> {
  req.session.account = {
    id: account.id,
    createdDate: account.createdDate,
    email: account.email,
    firstName: account.firstName,
    lastName: account.lastName,
    bornDate: account.bornDate,
    isVerified: account.isVerified,
    lastBookRecommandation: account.lastBookRecommandation,
    lastMovieRecommandation: account.lastMovieRecommandation,
    preferences: account.preferences,
    spentMinutesReadingAndWatching: NaN,
    role: account.role
  }
  await calculateSpentMinutesReadingAndWatching(account).then((spentMinutes: number) => {
    req.session.account!.spentMinutesReadingAndWatching = spentMinutes
  }).catch((err: Error) => {
    throw new ApiError(`Failed calculating spent time reading and watching (${err.name}: ${err.message}).`)
  })
}

async function loginWithGoogle (account: oauthAccount): Promise<StatusCodes> {
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

async function loginAccount (req: Request, accountToLogin: accountRepositoryRequest): Promise<void> {
  await findEntity<Account>(Account, { email: accountToLogin.email }).then(async (foundAccount: Account | null) => {
    if (foundAccount == null) {
      throw new AccountDoesNotExistError()
    }
    await bcrypt.compare(accountToLogin.password + foundAccount.salt, foundAccount.password).then(async (comparison: boolean) => {
      if (!comparison) {
        throw new IncorrectEmailOrPasswordError(`Account's email or password is incorrect: ${accountToLogin.email}`)
      }
      await createSession(req, foundAccount)
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
