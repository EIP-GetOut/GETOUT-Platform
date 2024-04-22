/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { AppError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

async function getAccountsCreatedPastWeek (): Promise<number> {
  const accountRepository = appDataSource.getRepository(Account)

  const oneWeekAgo = new Date()
  oneWeekAgo.setDate(oneWeekAgo.getDate() - 7)

  const count = await accountRepository
    .createQueryBuilder('account')
    .where('account.createdDate >= :oneWeekAgo', { oneWeekAgo })
    .getCount()

  return count
}

async function getAccounts (page: number): Promise<any> {
  return await appDataSource.getRepository(Account).find({ take: 50, skip: (page - 1) * 50 }).then(async (accounts: Account []) => {
    return {
      list: accounts,
      accountCreatedLastWeek: await getAccountsCreatedPastWeek()
    }
  }).catch((err: AppError | Error) => {
    if (err instanceof AppError) {
      throw err
    } else {
      throw new AppError()
    }
  })
}

export { getAccounts }
