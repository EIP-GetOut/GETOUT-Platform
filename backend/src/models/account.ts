/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type SessionData } from 'express-session'
import { StatusCodes } from 'http-status-codes'

import { AccountDoesNotExistError, NotLoggedInError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

async function deleteAccount (sess: Partial<SessionData>): Promise<StatusCodes> {
  const accountRepository = appDataSource.getRepository(Account)
  if (sess.account == null) {
    throw new NotLoggedInError()
  }
  await findEntity<Account>(Account, { id: sess.account.id }).then(async (foundAccount: Account | null) => {
    if (foundAccount == null) {
      throw new AccountDoesNotExistError()
    }
    await accountRepository.delete(sess.account?.id as string)
    return StatusCodes.OK
  })
  return StatusCodes.BAD_REQUEST
}

export default deleteAccount

export { deleteAccount }
