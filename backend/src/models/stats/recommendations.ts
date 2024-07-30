/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

async function getNbRecommendationsThisWWeek (): Promise<number> {
  const accountRepository = appDataSource.getRepository(Account)

  const count = await accountRepository.count()

  return count * 70
}

export { getNbRecommendationsThisWWeek }
