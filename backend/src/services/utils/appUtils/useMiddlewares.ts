/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import compression from 'compression'
import cors from 'cors'
import express, { type NextFunction, type Application, type Request, type Response } from 'express'
import rateLimit from 'express-rate-limit'
import helmet from 'helmet'

import logger from '@middlewares/logging'

import { findEntity } from '@models/getObjects'

import { type Account } from '@entities/Account'

type StaticOrigin = boolean | string | RegExp | Array<boolean | string | RegExp>
type CustomOrigin = (requestOrigin: string | undefined,
  callback: (err: Error | null, origin?: StaticOrigin) => void) => void

function matchRuleShort (str: string, rule: string): boolean {
  // eslint-disable-next-line no-useless-escape
  const esc = (s: string): string => s.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, '\\$1')
  return new RegExp('^' + rule.split('*').map(esc).join('.*') + '$').test(str)
}

function useCors (app: Application): void {
  const customOrigin: CustomOrigin = (origin, callback) => {
    if (origin == null) { callback(null, true); return }
    if (!matchRuleShort(origin ?? 'localhost', process.env.ORIGIN_PATTERN ?? '*')) {
      callback(new Error(`${origin ?? ''} is not allowed by CORS`)); return
    }
    callback(null, true)
  }
  app.use(cors({
    origin: customOrigin,
    credentials: true
  }))
}

function useRateLimit (app: Application): void {
  if (process.env.NODE_ENV === 'production') {
    app.use(rateLimit({
      windowMs: 1 * 60 * 1000, // 1 minute
      max: 100 // limit each IP to 100 requests per windowMs
    }))
  }
}

function useUncacheErrors (app: Application): void {
  app.use((req, res, next) => {
    res.on('end', () => {
      if (res.statusCode >= 400) {
        logger.debug('Error response hence not cached')
        res.set('Cache-control', 'no-store')
      }
    })
    next()
  })
}

function useSessionMappedToAccount (app: Application): void {
  app.use((req: Request, res: Response, next: NextFunction) => {
    res.on('finish', (): void => {
      if (req.session?.account == null) {
        return
      }
      findEntity<Account>('Account', { id: req.session.account.id }).then(async (account: Account | null): Promise<void> => {
        if (account == null) {
          logger.error('Failed remaping session.')
          return
        }
        const sessAccount: any = { ...account }
        delete sessAccount.password
        delete sessAccount.salt
        delete sessAccount.passwordResetCode
        delete sessAccount.passwordResetExpiration
        delete sessAccount.emailVerificationCode
        delete sessAccount.emailVerificationExpiration
        delete sessAccount.passwordResetExpiration
        sessAccount.spentMinutesReadingAndWatching = NaN
        req.session.account = sessAccount

        const week = 3600000 * 24 * 7
        req.session.cookie.expires = new Date(Date.now() + week)
        req.session.cookie.maxAge = week

        req.session.save()
      }).catch(console.error)
    })
    next()
  })
}

function useMiddlewares (app: Application): void {
  useCors(app)
  app.use(compression())
  app.use(helmet())
  app.use(express.json())
  useRateLimit(app)
  useUncacheErrors(app)
  if (process.env.NODE_ENV !== 'test') {
    useSessionMappedToAccount(app)
  }
}

export default useMiddlewares
