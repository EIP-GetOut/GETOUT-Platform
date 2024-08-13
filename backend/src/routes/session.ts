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

import { AccountDoesNotExistError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'
import { calculateSpentMinutesWatching, calculateTotalPagesRead } from '@services/utils/timeCalculations'

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
  if (req.session.account?.id == null) {
    res.status(StatusCodes.OK).json(req.session)
  }

  let account: Account

  findEntity<Account>(Account, { id: req.session.account?.id }).then(async (res: Account | null) => {
    if (res == null) {
      throw new AccountDoesNotExistError()
    }
    account = res
    return await mapAccountToSession(req)
  }).then(async () => {
    return await Promise.all([
      calculateSpentMinutesWatching(account), calculateTotalPagesRead(account)
    ])
  }).then(([spentMinutesWatching, totalPagesRead]) => {
    req.session.account!.spentMinutesWatching = spentMinutesWatching
    req.session.account!.totalPagesRead = totalPagesRead
    res.status(StatusCodes.OK).json(req.session)
  }).catch(handleErrorOnRoute(res))
})

export default router
