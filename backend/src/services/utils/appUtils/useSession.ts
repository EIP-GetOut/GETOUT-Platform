/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import RedisStore from 'connect-redis'
import { type UUID } from 'crypto'
import { type Application } from 'express'
import session, { type SessionOptions } from 'express-session'
import { type RedisClientType } from 'redis'

import { type Preferences } from '@models/account/preferences.interface'

import { type Role } from '@entities/Role'

import { getRedisClient } from '../redisClient'

export interface SessionAccount {
  id: UUID
  email: string
  firstName?: string
  lastName?: string
  bornDate?: Date
  createdDate: Date
  preferences?: Preferences
  lastMovieRecommandation: Date | null
  lastBookRecommandation: Date | null
  spentMinutesWatching: number
  totalPagesRead: number
  secondsBeforeNextMovieRecommendation: number | null
  secondsBeforeNextBookRecommendation: number | null
  role: Role
  isVerified: boolean
  /* This will be deleted when not necessary for the frontend anymore */
  watchlist: number []
  readingList: string []
  likedMovies: number []
  likedBooks: string []
  dislikedMovies: number []
  dislikedBooks: string []
  seenMovies: number []
  readBooks: string []
  recommendedBooksHistory: string []
  recommendedMoviesHistory: number []
}

declare module 'express-session' {
  export interface SessionData {
    account: SessionAccount
  }
}

function useSession (app: Application): RedisClientType {
  const week = 3600000 * 24 * 7

  const redisClient = getRedisClient()
  const redisStore = new RedisStore({ client: redisClient })
  const sess: SessionOptions = {
    store: redisStore,
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: {
      maxAge: week,
      sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'strict'
    }
  }
  if (process.env.NODE_ENV === 'production') {
    app.set('trust proxy', 1)
    if (sess.cookie != null) {
      sess.cookie.secure = true
    }
  }

  app.use(session(sess))
  return redisClient
}

export default useSession
