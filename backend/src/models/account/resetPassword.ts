/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import bcrypt from 'bcrypt'
import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

async function changeAccountPassword (accountId: UUID, oldPassword: string, newPassword: string): Promise<StatusCodes> {
  return await findEntity<Account>(Account, { id: accountId }).then((account: Account | null): StatusCodes | Promise <StatusCodes> => {
    if (account == null) {
      return StatusCodes.NOT_FOUND
    }
    return bcrypt.compare(oldPassword + account.salt, account.password).then(async (passwordsDoesMatch) => {
      return await bcrypt.hash(newPassword + account.salt, 10).then(async (hash: string) => {
        if (passwordsDoesMatch) {
          account.password = hash
          return await appDataSource.getRepository<Account>('Account').save(account).then(() => {
            return StatusCodes.OK
          })
        }

        return StatusCodes.FORBIDDEN
      })
    })
  })
}

export { changeAccountPassword }
