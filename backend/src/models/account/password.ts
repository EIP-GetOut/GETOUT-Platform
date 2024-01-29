/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import bcrypt from 'bcrypt'
import { type UUID, randomBytes } from 'crypto'
import { StatusCodes } from 'http-status-codes'
import { type FindOptionsWhere } from 'typeorm'
import { v4 as uuidv4 } from 'uuid'

import { AccountDoesNotExistError, AuthenticationError, DbError, SamePasswordError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

function getDateIn1Hour (): Date {
  const current = new Date()
  const followingDay = new Date(current.getTime() + 3000000) // + 1 hour in ms

  return followingDay
}

async function generateResetPasswordUrl (accountId: UUID, email?: string): Promise<string> {
  const criteria: FindOptionsWhere<Account> = { id: accountId, email }

  return await findEntity<Account>(Account, criteria).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    account.passwordResetExpiration = getDateIn1Hour()
    account.passwordResetToken = uuidv4()
    const pswd: number = randomBytes(4).readInt32LE()
    account.passwordResetPassword = pswd
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((account: Account) => {
    if (account?.passwordResetPassword == null) {
      throw new DbError('Failed generating password url.')
    }
    return `/reset-password?token=${account.passwordResetToken}&password=${account.passwordResetPassword.toString()}`
  })
}

async function accountIsAllowedToResetPassword (token: string, password: number): Promise<boolean> {
  return await findEntity<Account>(Account, { passwordResetToken: token }).then((account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    console.warn('PASSWORD:', password, 'PASSWORDRESETPASS:', account.passwordResetPassword, ':', 'account.passwordResetExpiration:', account.passwordResetExpiration)
    return (
      password === account.passwordResetPassword &&
      account.passwordResetExpiration !== null &&
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

async function changeAccountPasswordFromToken (token: string, newPassword: string): Promise<Account> {
  let foundAccount: Account

  return await findEntity<Account>(Account, { passwordResetToken: token }).then(async (account: Account | null) => {
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
    foundAccount.passwordResetToken = null
    foundAccount.passwordResetPassword = null
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
  changeAccountPasswordFromToken,
  generateResetPasswordUrl
}
