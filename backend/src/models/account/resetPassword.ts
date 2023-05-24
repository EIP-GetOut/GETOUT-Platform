/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { StatusCodes } from 'http-status-codes'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

function changeAccountPassword (accountId, oldPassword, newPassword, newSalt): Promise<StatusCodes> {
  return findEntity<Account>(Account, { id: accountId }).then((account: Account | null): any => {
    if (!account || oldPassword  !== account.password) {
      return StatusCodes.FORBIDDEN
    }
    account.salt = newSalt
    account.password = newPassword
    return appDataSource.getRepository<Account>('Account').save(account).then(() => {
      return StatusCodes.OK
    })
  })
}

export { changeAccountPassword }
