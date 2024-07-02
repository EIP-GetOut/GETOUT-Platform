/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import { sendBetaInvitationEmail, sendEmailVerificationEmail } from '@services/brevo/emails'
import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AlreadyLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { modifyAccount } from '@models/account'
import registerAccount from '@models/account/registerAccount'
import { generateEmailVerificationCode } from '@models/account/verifyEmail'

import { type Account } from '@entities/Account'

const router = Router()

const rulesPost = [
  body('email').isEmail(),
  body('firstName').isString(),
  body('lastName').isString(),
  body('bornDate').isDate({ format: 'DD/MM/YYYY' }),
  body('password').isString(),
  body('isForBeta').isBoolean().default(false).optional()
]

/**
 * @swagger
 * /account/signup:
 *   post:
 *     summary: Create an account
 *     description: Create a new user account and store the provided information in the database.
 *     parameters:
 *       - in: body
 *         name: requestBody
 *         description: Account details
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             email:
 *               type: string
 *               format: email
 *             firstName:
 *               type: string
 *             lastName:
 *               type: string
 *             bornDate:
 *               type: string
 *               format: date
 *             password:
 *               type: string
 *     responses:
 *       '201':
 *         description: Account created successfully.
 *       '400':
 *         description: Bad request. Invalid input data.
 *       '500':
 *         description: Internal server error.
 */

router.post('/account/signup', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id != null) {
    handleErrorOnRoute(res)(new AlreadyLoggedInError())
    return
  }
  registerAccount(req.body).then(async (account: Account) => {
    const response: Partial<Account> = {
      id: account.id,
      email: account.email,
      firstName: account.firstName,
      lastName: account.lastName,
      bornDate: account.bornDate,
      preferences: account.preferences,
      createdDate: account.createdDate
    }

    if (req.body.isForBeta === true) {
      return await sendBetaInvitationEmail(account, req.body.password).then(async (resp) => {
        console.log('RESP:', resp)
        return await modifyAccount(account.id, { isVerified: true })
      }).then(() => {
        return res.status(StatusCodes.CREATED).json(response)
      })
    }
    return await generateEmailVerificationCode(account.email).then(async (code) => {
      logger.debug(`Sending email verification code to email ${account.email} : ${code}.`)
      return await sendEmailVerificationEmail(account, code)
    }).then(() => {
      return res.status(StatusCodes.CREATED).json(response)
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
