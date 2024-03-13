/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { getBook } from '@models/book'
import { getMovie } from '@models/movie'

import { type SessionAccount } from './appUtils/useSession'

async function calculateSpentMinutesReadingAndWatching (account: SessionAccount): Promise<number> {
  const promisesArray: Array<Promise<any>> = []
  let spentMinutes: number = 0

  account.seenMovies.forEach((seenMovieId: number) => {
    promisesArray.push(getMovie(seenMovieId))
  })
  account.readBooks.forEach((readBookId: string) => {
    promisesArray.push(getBook(readBookId))
  })
  return await Promise.all(promisesArray).then(async (resolvedPromises: any []) => {
    resolvedPromises.forEach((resolvedPromise: any) => {
      const duration = resolvedPromise.duration != null
        ? resolvedPromise.duration as number
        : resolvedPromise.pageCount as number * 2
      if (duration > 0) { spentMinutes += duration }
    })
    return spentMinutes
  })
}

export default calculateSpentMinutesReadingAndWatching