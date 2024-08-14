/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request } from 'express'
import { type Session, type SessionData } from 'express-session'

import logger from '@services/middlewares/logging'
import { getMissingTimeBeforeNextRecommendation } from '@services/utils/timeCalculations'

import { findEntity } from '@models/getObjects'

import { type Account } from '@entities/Account'

import { SessionMappingError } from './customErrors'

async function mapAccountToSession (req: Request, isTemporary: boolean = false): Promise<Session & Partial<SessionData>> {
  if (req.session?.account == null) {
    return await Promise.resolve(req.session)
  }
  return await findEntity<Account>('Account', { id: req.session.account.id }, { role: true }).then(async (account: Account | null) => {
    if (account == null) {
      logger.error('Failed remaping session.')
      throw new SessionMappingError()
    }
    console.log(account)
    req.session.account = {
      id: account.id,
      createdDate: account.createdDate,
      email: account.email,
      firstName: account.firstName,
      lastName: account.lastName,
      bornDate: account.bornDate,
      isVerified: account.isVerified,
      lastBookRecommandation: account.lastBookRecommandation,
      lastMovieRecommandation: account.lastMovieRecommandation,
      preferences: account.preferences,
      spentMinutesWatching: NaN,
      totalPagesRead: NaN,
      secondsBeforeNextMovieRecommendation: account.lastMovieRecommandation != null
        ? getMissingTimeBeforeNextRecommendation(account.lastMovieRecommandation)
        : null,
      secondsBeforeNextBookRecommendation: account.lastBookRecommandation != null
        ? getMissingTimeBeforeNextRecommendation(account.lastBookRecommandation)
        : null,
      role: account.role,
      /* This will be deleted when not necessary for the frontend anymore */
      watchlist: account.watchlist,
      readingList: account.readingList,
      likedMovies: account.likedMovies,
      likedBooks: account.likedBooks,
      dislikedMovies: account.dislikedMovies,
      dislikedBooks: account.dislikedBooks,
      seenMovies: account.seenMovies,
      readBooks: account.readBooks,
      recommendedBooksHistory: account.recommendedBooksHistory,
      recommendedMoviesHistory: account.recommendedMoviesHistory
    }

    const week = 3600000 * 24 * 7
    const hour = 3600000
    req.session.cookie.expires = new Date(Date.now() + (isTemporary ? hour : week))
    req.session.cookie.maxAge = (isTemporary ? hour : week)

    return await new Promise<Session & Partial<SessionData>>((resolve, _reject) => {
      return req.session.save((err: any) => {
        if (err != null) {
          throw new SessionMappingError(`Failed saving session: ${String(err)}.`)
        }
        resolve(req.session)
      })
    })
  })
}

export { mapAccountToSession }
