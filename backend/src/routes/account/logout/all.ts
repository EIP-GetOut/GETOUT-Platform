/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'
import { type Response, type Request, Router } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { AppError, NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

const router = Router()

async function promisedStoreDestroy (store: Express.SessionStore, sid: string): Promise<void> {
  await new Promise<void>((resolve, reject) => {
    store.destroy(sid, (err: any) => {
      if (err != null) {
        reject(err)
        return
      }
      resolve()
    })
  })
}

async function deleteAllSessionsOfSameAccount (store: Express.SessionStore, accountId: UUID): Promise<void> {
  const promisesArray: Array<Promise<void>> = []

  await new Promise<void>((resolve, reject) => {
    store.all?.((err: any, sessions?: any) => {
      if (err != null || sessions == null) {
        reject(err)
        return
      }
      sessions.forEach((session: any) => {
        if (session.account?.id === accountId) {
          promisesArray.push(promisedStoreDestroy(store, session.id))
        }
      })
      Promise.all(promisesArray).then(() => {
        resolve()
      }).catch(reject)
    })
  })
}

/**
 * @swagger
 * /account/logout/all:
 *   post:
 *     summary: Log out all sessions.
 *     description: Log out all connected sessions associated with the authenticated account.
 *     responses:
 *       '204':
 *         description: Successfully logged out all sessions of the account.
 *       '500':
 *         description: Internal server error.
 */
router.post('/account/logout/all', validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  deleteAllSessionsOfSameAccount(req.sessionStore, req.session.account.id).then(() => {
    return res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  }).catch((err) => {
    if (err != null) {
      handleErrorOnRoute(res)(new AppError(err.message ?? undefined))
    }
    return res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  })
})

export default router
