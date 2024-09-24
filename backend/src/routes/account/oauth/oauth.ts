/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'

import { loginWithGoogle } from '@models/account/loginAccount'

const router = Router()

const rulesPost = [
  body('email').isEmail(),
  body('idToken').isString()
]

/**
 * @swagger
 * /account/oauth:
 *   post:
 *     summary: Process Google OAuth
 *     description: Process Google OAuth with the provided email and idToken.
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
 *             idToken:
 *               type: string
 *               description: Google ID token
 *     responses:
 *       '200':
 *         description: Successful login or authentication.
 *       '400':
 *         description: Invalid request data.
 *       '401':
 *         description: Unauthorized access.
 *       '500':
 *         description: Internal server error.
 */
router.post('/account/oauth', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  loginWithGoogle(req.body).then(async (code: StatusCodes) => {
    if (code === StatusCodes.OK) {
      logger.info(`Account successfully logged in ${req.body.email ?? ''} !`)
    } else {
      logger.info(`Account's email or password is incorrect: ${req.body.email != null || req.body.githubCode}`)
    }
    res.status(code).send(getReasonPhrase(code))
  }).catch(async (err: any) => {
    logger.error(err)
    res.status(StatusCodes.INTERNAL_SERVER_ERROR)
      .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
  })
})

export default router
