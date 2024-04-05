/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'

import { AccountDoesNotExistError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'

import { type Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

async function addRecommendedBooksToHistory (recommendations: any [], accountId: UUID): Promise<void> {
  await findEntity<Account>('Account', { id: accountId }).then(async (account: Account | null): Promise<void> => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (account.recommendedBooksHistory.length === 50) {
      account.recommendedBooksHistory.splice(0, 5)
    }
    recommendations.forEach((recommandation) => {
      account.recommendedBooksHistory.push(recommandation.id)
    })
    await appDataSource.getRepository<Account>('Account').save(account)
  })
}

async function addRecommendedMoviesToHistory (recommendations: any [], accountId: UUID): Promise<void> {
  await findEntity<Account>('Account', { id: accountId }).then(async (account: Account | null): Promise<void> => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (account.recommendedMoviesHistory.length === 50) {
      account.recommendedMoviesHistory.splice(0, 5)
    }
    recommendations.forEach((recommandation) => {
      account.recommendedMoviesHistory.push(recommandation.id)
    })
    await appDataSource.getRepository<Account>('Account').save(account)
  })
}

export {
  addRecommendedBooksToHistory,
  addRecommendedMoviesToHistory
}
