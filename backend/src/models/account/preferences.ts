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

import { type Preferences } from './preferences.interface'

async function addPreferences (accountId: UUID, preferencesToAdd: Preferences, preferences: keyof Account): Promise<Preferences> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    account.preferences = preferencesToAdd
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount?.preferences == null) {
      throw new DbError('Failed adding preferences to the db.')
    }
    return savedAccount.preferences
  }).catch((err) => {
    throw new Error(err)
  })
}

async function postPreferences (accountId: UUID, preferencesToAdd: Preferences, preferences: keyof Account): Promise<Preferences> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (account.preferences !== null) {
      throw new PreferencesAlreadyExistError(undefined, StatusCodes.CONFLICT)
    }
    account.preferences = preferencesToAdd
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount?.preferences == null) {
      throw new DbError('Failed adding preferences to the db.')
    }
    return savedAccount.preferences
  }).catch((err) => {
    throw new Error(err)
  })
}

export { addPreferences, postPreferences }
