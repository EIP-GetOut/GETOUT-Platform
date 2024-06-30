/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request } from 'express'
import { type Session, type SessionData } from 'express-session'

import logger from '@services/middlewares/logging'

import { findEntity } from '@models/getObjects'

import { type Account } from '@entities/Account'

import { SessionMappingError } from './customErrors'

async function mapAccountToSession (req: Request): Promise<Session & Partial<SessionData>> {
  if (req.session?.account == null) {
    return await Promise.resolve(req.session)
  }
  return await findEntity<Account>('Account', { id: req.session.account.id }).then(async (account: Account | null) => {
    if (account == null) {
      logger.error('Failed remaping session.')
      throw new SessionMappingError()
    }
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
      spentMinutesReadingAndWatching: NaN,
      role: account.role
    }

    const week = 3600000 * 24 * 7
    req.session.cookie.expires = new Date(Date.now() + week)
    req.session.cookie.maxAge = week

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
