/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { changeAccountEmail } from '@models/account/email'

const router = Router()

const rulesPost = [
  body('email').isString()
]

/**
 * @swagger
 * /account/change-email/:
 *   post:
 *     summary: Change account email
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
router.post('/account/change-email/', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  changeAccountEmail(req.session.account.id, req.body.email).then(async () => {
    await mapAccountToSession(req, true)
    res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  }).catch(handleErrorOnRoute(res))
})

export default router
