/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { AccountDoesNotExistError, ApiError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'
import calculateSpentMinutesReadingAndWatching from '@services/utils/spentTimeCalculation'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /session:
 *   get:
 *     summary: Get current session
 *     description: Retrieve the details of the current session.
 *     responses:
 *       '200':
 *         description: Current session details.
 *         schema:
 *           type: object
 */
router.get('/session', validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id != null) {
    findEntity<Account>(Account, { id: req.session.account?.id }).then(async (account: Account | null) => {
      if (account == null) {
        throw new AccountDoesNotExistError()
      }
      await mapAccountToSession(req).then(async (session) => {
        await calculateSpentMinutesReadingAndWatching(account).then((spentMinutes: number) => {
          session.account!.spentMinutesReadingAndWatching = spentMinutes
          res.status(StatusCodes.OK).json(req.session)
        }).catch((err: Error) => {
          throw new ApiError(`Failed calculating spent time reading and watching (${err.name}: ${err.message}).`)
        })
      })
    }).catch(handleErrorOnRoute)
  } else {
    res.status(StatusCodes.OK).json(req.session)
  }
})

export default router
