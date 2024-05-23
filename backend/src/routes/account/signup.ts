/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { SendSmtpEmail, TransactionalEmailsApi } from '@getbrevo/brevo'
import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AlreadyLoggedInError, ApiError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import registerAccount from '@models/account/registerAccount'

import { type Account } from '@entities/Account'

const router = Router()

const rulesPost = [
  body('email').isEmail(),
  body('firstName').isString(),
  body('lastName').isString(),
  body('bornDate').isDate({ format: 'DD/MM/YYYY' }),
  body('password').isString()
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

async function sendWelcomeEmail (account: Account): Promise<ReturnType<TransactionalEmailsApi['sendTransacEmail']>> {
  const apiInstance = new TransactionalEmailsApi()
  apiInstance.setApiKey(0, process.env.BREVO_API_KEY)
  const sendSmtpEmail = new SendSmtpEmail()

  sendSmtpEmail.templateId = 5
  sendSmtpEmail.to = [{ email: account.email }]
  sendSmtpEmail.params = { fullName: `${account.firstName} ${account.lastName}` }

  return await apiInstance.sendTransacEmail(sendSmtpEmail).catch((err: Error) => {
    throw new ApiError(`Error while sending reset password email to ${account.email}: ${err.message}.`)
  })
}

router.post('/account/signup', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id != null) {
    handleErrorOnRoute(res)(new AlreadyLoggedInError())
    return
  }
  registerAccount(req.body).then(async (account: Account) => {
    return await sendWelcomeEmail(account).then(() => {
      return res.status(StatusCodes.CREATED).json({
        id: account.id,
        email: account.email,
        firstName: account.firstName,
        lastName: account.lastName,
        bornDate: account.bornDate,
        preferences: account.preferences,
        createdDate: account.createdDate
      })
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
