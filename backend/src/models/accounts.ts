/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import logger from '@services/middlewares/logging'
import { AppError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

async function getAccounts (page: number): Promise<any> {
  return await appDataSource.getRepository(Account).find({ take: 50, skip: (page - 1) * 50 }).then((accounts: Account []) => {
    return accounts
  }).catch((err: AppError | Error) => {
    if (err instanceof AppError) {
      throw err
    } else {
      throw new AppError()
    }
  })
}

export { getAccounts }
