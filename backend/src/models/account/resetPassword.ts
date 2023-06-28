/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import bcrypt from 'bcrypt'
import { StatusCodes } from 'http-status-codes'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'


function changeAccountPassword (accountId, oldPassword, newPassword): Promise<StatusCodes> {
  return findEntity<Account>(Account, { id: accountId }).then((account: Account | null): any => {
    if (!account) {
      return StatusCodes.NOT_FOUND
    }
    return bcrypt.compare(oldPassword + account.salt, account.password).then((passwordsDoesMatch) => {
      console.log('PASSWORD MATCH ?', passwordsDoesMatch)

      return bcrypt.hash(newPassword + account.salt, 10).then((hash: string) => {

      if (passwordsDoesMatch) {
        account.password = hash
        return appDataSource.getRepository<Account>('Account').save(account).then(() => {
          return StatusCodes.OK
        })
      }

      return StatusCodes.FORBIDDEN
    })

  })
  })
}

export { changeAccountPassword }
