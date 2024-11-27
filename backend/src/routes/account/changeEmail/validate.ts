/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { verifyNewEmail } from '@models/account/email'
import { accountIsAllowedToVerifyEmail } from '@models/account/verifyEmail'

const router = Router()

const rulesPost = [
  body('code').isNumeric()
]

/**
 * @swagger
 * /account/change-email/validate:
 *   post:
 *     summary: Validate change account email
 *     description: Change the email of the logged-in user by verifying the current email and replacing it with a new one.
 *     parameters:
 *       - in: body
 *         name: requestBody
 *         description: Password change details
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             email:
 *               type: string
 *     responses:
 *       '200':
 *         description: Password changed successful.
 *       '400':
 *         description: Bad request. Invalid input data.
 *       '403':
 *         description: Forbidden. User not authenticated.
 *       '500':
 *         description: Internal server error.
 */
router.post('/account/change-email/validate', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  accountIsAllowedToVerifyEmail(req.session.account.id, req.body.code, true).then(async (isAllowed: boolean) => {
    if (!isAllowed) {
      logger.error('Account is not allowed to verify email.')
      res.status(StatusCodes.FORBIDDEN).send(getReasonPhrase(StatusCodes.FORBIDDEN))
      return
    }
    await verifyNewEmail(req.session.account!.id)
  }).then(() => {
    res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  }).catch(handleErrorOnRoute(res))
})

export default router
