/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Request, Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { changeAccountPassword } from '@models/account/resetPassword'

const router = Router()

const rulesPost = [
  body('password').isString(),
  body('newPassword').isString()
]

/**
 * @swagger
 * /account/reset-password/:
 *   post:
 *     summary: Reset account password
 *     description: Reset the password of the logged-in user by verifying the current password and replacing it with a new one.
 *     parameters:
 *       - in: body
 *         name: requestBody
 *         description: Password reset details
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             password:
 *               type: string
 *             newPassword:
 *               type: string
 *     responses:
 *       '200':
 *         description: Password reset successful.
 *       '400':
 *         description: Bad request. Invalid input data.
 *       '403':
 *         description: Forbidden. User not authenticated.
 *       '500':
 *         description: Internal server error.
 */
router.post('/account/reset-password/', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (!req.session?.account?.id) {
    return res.status(StatusCodes.FORBIDDEN).send(getReasonPhrase(StatusCodes.FORBIDDEN))
  }
  return changeAccountPassword(req.session?.account?.id, req.body.password, req.body.newPassword).then((code: StatusCodes) => {
    return res.status(code).send(getReasonPhrase(code))
  }).catch((err) => {
    logger.error(err.toString())
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR)
      .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
  })
})

export default router
