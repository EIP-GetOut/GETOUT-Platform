/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import compression from 'compression'
import cors from 'cors'
import express, { type Application } from 'express'
import rateLimit from 'express-rate-limit'
import helmet from 'helmet'
import cron from 'node-cron'

import logger from '@middlewares/logging'

import { sendInactivityEmails } from '@services/cronjobs/inactivityEmails'

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

function useInactivityEmails (app: Application): void {
  cron.schedule('0 0 * * *', () => {
    logger.info('Running daily inactivity check...')
    sendInactivityEmails().catch((err: Error) => {
      logger.error(`${err.name}: ${err.message}`)
    })
  }, { scheduled: true })
}

function useMiddlewares (app: Application): void {
  useCors(app)
  app.use(compression())
  app.use(helmet())
  app.use(express.json())
  useRateLimit(app)
  useUncacheErrors(app)
  useInactivityEmails(app)
}

export default useMiddlewares
