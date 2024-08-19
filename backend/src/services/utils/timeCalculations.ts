/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type BookResponse, getBook } from '@services/googlebooks/getBook'
import { type MovieResponse, getMovie } from '@services/tmdb/getMovie'

import { type Account } from '@entities/Account'

import { AppError } from './customErrors'

function getMissingTimeBeforeNextRecommendation (lastRecommandation: Date): number {
  const now = Date.now()
  const interval = process.env.RECOMMENDATIONS_INTERVAL_SECONDS

  const result = interval - ((now - new Date(lastRecommandation).getTime()) / 1000)
  return Math.trunc(Math.max(result, 0))
}

async function calculateSpentMinutesWatching (account: Account): Promise<number> {
  let spentMinutesWatching: number = 0

  return await Promise.all(account.seenMovies.map(getMovie)).then(async (resolvedPromises: MovieResponse []) => {
    resolvedPromises.forEach((resolvedPromise: MovieResponse) => {
      const duration = resolvedPromise.duration
      if (duration > 0) { spentMinutesWatching += duration }
    })
    return spentMinutesWatching
  }).catch((err: Error | AppError) => {
    if (err instanceof AppError) {
      throw err
    }
    throw new AppError(`Failed calculating spent minutes watching (${err.name}: ${err.message}).`)
  })
}

async function calculateTotalPagesRead (account: Account): Promise<number> {
  let totalPagesRead: number = 0

  return await Promise.all(
    account.readBooks.map(async (id) => (await getBook(id, true)))
  ).then(async (resolvedPromises: BookResponse []) => {
    resolvedPromises.forEach((resolvedPromise: BookResponse) => {
      const nbPages = resolvedPromise.pageCount
      if (nbPages !== null && nbPages > 0) { totalPagesRead += nbPages }
    })
    return totalPagesRead
  })
}

export {
  calculateSpentMinutesWatching,
  calculateTotalPagesRead,
  getMissingTimeBeforeNextRecommendation
}
