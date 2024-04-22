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

import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import calculateSpentMinutesReadingAndWatching from '@services/utils/spentTimeCalculation'

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
    calculateSpentMinutesReadingAndWatching(req.session.account).then((spentMinutes: number) => {
      req.session.account!.spentMinutesReadingAndWatching = spentMinutes
      res.status(StatusCodes.OK).json(req.session)
    }).catch(handleErrorOnRoute(res))
  } else {
    res.status(StatusCodes.OK).json(req.session)
  }
})

export default router
