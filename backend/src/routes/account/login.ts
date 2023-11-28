/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AlreadyLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { loginAccount } from '@models/account/loginAccount'

const router = Router()

const rulesPost = [
  body('email').isEmail(),
  body('password').isString()
]

/**
 * @swagger
 * /account/login:
 *   post:
 *     summary: Log in with email and password
 *     description: Log in to the user account using the provided email and password in the request body.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - name: body
 *         in: body
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             email:
 *               type: string
 *               format: email
 *               description: The email associated with the user account.
 *             password:
 *               type: string
 *               description: The password for the user account.
 *     responses:
 *       '200':
 *         description: Successfully logged in.
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - invalid email or password.
 *       '500':
 *         description: Internal server error.
 */
router.post('/account/login', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id != null) {
    handleErrorOnRoute(res)(new AlreadyLoggedInError())
    return
  }
  loginAccount(req.body, req.session).then((code: StatusCodes) => {
    if (code === StatusCodes.OK) {
      logger.info(`Account successfully logged in${req.body.email != null ? `: ${req.body.email}` : ' !'}`)
    } else {
      logger.info(`Account's email or password is incorrect: ${req.body.email != null || req.body.githubCode}`)
    }
    return res.status(code).send(getReasonPhrase(code))
  }).catch(handleErrorOnRoute(res))
})

export default router
