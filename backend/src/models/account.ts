/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type UUID } from 'crypto'
import { type SessionData } from 'express-session'
import { StatusCodes } from 'http-status-codes'

import { AccountDoesNotExistError, DbError, NotLoggedInError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

async function deleteAccount (sess: Partial<SessionData>): Promise<StatusCodes> {
  const accountRepository = appDataSource.getRepository(Account)
  if (sess.account == null) {
    throw new NotLoggedInError()
  }
  return await findEntity<Account>(Account, { id: sess.account.id }).then(async (foundAccount: Account | null) => {
    if (foundAccount == null) {
      throw new AccountDoesNotExistError()
    }
  }).then(async () => {
    await accountRepository.delete(sess.account?.id as string)
    return StatusCodes.NO_CONTENT
  }).catch(() => {
    return StatusCodes.BAD_REQUEST
  })
}

async function modifyAccount (accountId: UUID, propertiesToChange: Partial<Account>): Promise<void> {
  const accountRepository = appDataSource.getRepository(Account)
  await findEntity<Account>(Account, { id: accountId }).then(async (foundAccount: Account | null) => {
    if (foundAccount == null) {
      throw new AccountDoesNotExistError()
    }
    for (const propertyToModify in propertiesToChange) {
      (foundAccount as any)[propertyToModify] = (propertiesToChange as any)[propertyToModify]
    }
    await accountRepository.save(foundAccount).catch((err) => {
      throw new DbError(`Failed patching account in DB (${err}).`)
    })
  })
}

export { deleteAccount, modifyAccount }
