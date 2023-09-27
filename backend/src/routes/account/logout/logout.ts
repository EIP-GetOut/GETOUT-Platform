/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { AppError, NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

const router = Router()

const rules = [
]

/**
 * @swagger
 * /account/logout:
 *   post:
 *     summary: Log out
 *     description: Log out from the user account if a session is present.
 *     responses:
 *       '204':
 *         description: Successfully logged out.
 *       '500':
 *         description: Internal server error.
 */
router.post('/account/logout', rules, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  return req.session.destroy((err) => {
    if (err != null) {
      handleErrorOnRoute(res)(new AppError(err.message ?? undefined))
    }
    return res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  })
})

export default router
