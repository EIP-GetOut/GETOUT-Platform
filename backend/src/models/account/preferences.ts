/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'

import { AccountDoesNotExistError, DbError, PreferencesAlreadyExistError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { type preferences } from './preferences.intefaces'

async function addPreferences (accountId: UUID, preferencesToAdd: preferences, preferences: keyof Account): Promise<string[]> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    (account[preferences] as preferences) = (preferencesToAdd)
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount == null) {
      throw new DbError('Failed adding book to the reading list.')
    }
    return savedAccount[preferences] as string []
  }).catch((err) => {
    throw new Error(err)
  })
}

async function postPreferences (accountId: UUID, preferencesToAdd: preferences, preferences: keyof Account): Promise<string[]> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (account.preferences !== null) {
      throw new PreferencesAlreadyExistError(undefined, StatusCodes.CONFLICT)
    }
    (account[preferences] as preferences) = (preferencesToAdd)
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount == null) {
      throw new DbError('Failed adding book to the reading list.')
    }
    return savedAccount[preferences] as string []
  }).catch((err) => {
    throw new Error(err)
  })
}

export { addPreferences, postPreferences }
