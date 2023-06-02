/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import RedisStore from "connect-redis"
import { Application } from "express"
import session, { SessionOptions } from 'express-session'
import { createClient } from 'redis'

interface SessionAccount {
  id: string
  email: string
  firstName?: string
  lastName?: string
  bornDate?: Date
  createdDate: Date
}

declare module 'express-session' {
  export interface SessionData {
    account: SessionAccount;
  }
}

function useSession (app: Application) {
  const week = 3600000 * 24 * 7
  // const thirtySeconds = 1000 * 30

  const redisClient = createClient({ url: 'redis://redis:6379' })
  redisClient.connect().catch(console.error)
  const redisStore = new RedisStore({ client: redisClient })
  const sess: SessionOptions = {
    store: redisStore,
    secret: process.env.SESSION_SECRET!,
    resave: false,
    saveUninitialized: false,
    cookie: {
      maxAge: week,
      sameSite: app.get('env') === 'production' ? 'none' : 'strict'
    }
  }
  if (app.get('env') === 'production') {
    app.set('trust proxy', 1)
    sess.cookie!.secure = true
  }

  app.use(session(sess))
}

export default useSession