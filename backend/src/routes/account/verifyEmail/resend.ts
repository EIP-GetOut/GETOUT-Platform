/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { sendEmailVerificationEmail } from '@services/brevo/emails'
import logger, { logApiRequest } from '@services/middlewares/logging'
import { AccountDoesNotExistError, AccountIsAlreadyVerifiedError, NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { generateEmailVerificationCode } from '@models/account/verifyEmail'
import { findEntity } from '@models/getObjects'

import { type Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /account/verify-email/resend:
 *   post:
 *     summary: Resends email verification's email
 *     description: Resends email verification's email if user is not verified yet.
 *     consumes:
 *       - application/json
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
router.post('/account/verify-email/resend', logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  findEntity<Account>('Account', { id: req.session.account.id }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    if (account.isVerified) {
      throw new AccountIsAlreadyVerifiedError()
    }
    return await generateEmailVerificationCode(account.email).then(async (code) => {
      logger.debug(`Sending email verification code to email ${account.email} : ${code}.`)
      return await sendEmailVerificationEmail(account, code)
    })
  }).then(() => {
    return res.status(StatusCodes.OK).json(getReasonPhrase(StatusCodes.OK))
  }).catch(handleErrorOnRoute(res))
})

export default router
