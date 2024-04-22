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
import { type RedisClientType, createClient } from 'redis'

import { type Preferences } from '@models/account/preferences.intefaces'

import { type Role } from '@entities/Role'

export interface SessionAccount {
  id: UUID
  email: string
  firstName?: string
  lastName?: string
  bornDate?: Date
  createdDate: Date
  preferences?: Preferences
  watchlist: number []
  readingList: string []
  likedMovies: number []
  likedBooks: string []
  dislikedMovies: number []
  dislikedBooks: string []
  seenMovies: number []
  readBooks: string []
  lastRecommandation?: Date
  recommendedBooksHistory: string []
  recommendedMoviesHistory: number []
  spentMinutesReadingAndWatching: number
  role: Role
}

declare module 'express-session' {
  export interface SessionData {
    account: SessionAccount
  }
}

function useSession (app: Application): RedisClientType {
  const week = 3600000 * 24 * 7

  const redisClient: RedisClientType = createClient({ url: `redis://${process.env.NODE_ENV === 'test' ? 'localhost' : 'redis'}:6379` })
  redisClient.connect().catch(console.error)
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
