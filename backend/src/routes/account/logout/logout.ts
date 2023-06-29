/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Request, Response, Router } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

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
  return req.session.destroy((err) => {
    if (err) {
      logger.error(err.toString())
      return res.status(StatusCodes.INTERNAL_SERVER_ERROR)
        .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
    }
    return res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  })
})

export default router
