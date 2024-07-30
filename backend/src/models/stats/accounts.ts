/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

async function getAccountsCreatedWeekBeforeLast (): Promise<number> {
  const accountRepository = appDataSource.getRepository(Account)

  const today = new Date()
  const oneWeekAgo = new Date(today)
  const twoWeeksAgo = new Date(today)

  oneWeekAgo.setDate(today.getDate() - 7)
  twoWeeksAgo.setDate(today.getDate() - 14)

  const count = await accountRepository
    .createQueryBuilder('account')
    .where('account.createdDate >= :twoWeeksAgo', { twoWeeksAgo })
    .andWhere('account.createdDate < :oneWeekAgo', { oneWeekAgo })
    .getCount()

  return count
}

export { getAccountsCreatedWeekBeforeLast }
