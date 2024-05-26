/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { SendSmtpEmail, TransactionalEmailsApi } from '@getbrevo/brevo'
import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { AccountDoesNotExistError, ApiError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { generatePasswordResetCode } from '@models/account/password'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

const rulesPost = [
  body('email').isEmail()
]

async function sendEmail (email: string, passwordResetCode: number): Promise<ReturnType<TransactionalEmailsApi['sendTransacEmail']>> {
  return await findEntity<Account>(Account, { email }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }

    const apiInstance = new TransactionalEmailsApi()
    apiInstance.setApiKey(0, process.env.BREVO_API_KEY)
    const sendSmtpEmail = new SendSmtpEmail()

    sendSmtpEmail.templateId = 9
    sendSmtpEmail.to = [{ email }]
    sendSmtpEmail.params = { fullName: `${account.firstName} ${account.lastName}`, code: passwordResetCode }

    logger.debug(`Sending email: "${account.firstName} ${account.lastName}: ${passwordResetCode}".`)
    return await apiInstance.sendTransacEmail(sendSmtpEmail).catch((err: Error) => {
      throw new ApiError(`Error while sending reset password email to ${email}: ${err.message}.`)
    })
  })
}

router.post('/account/reset-password/send-email', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  generatePasswordResetCode(req.body.email).then(async (passwordResetCode: number) => {
    return await sendEmail(req.body.email, passwordResetCode).then((sendEmailRes) => {
      return res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
    })
  }).catch(handleErrorOnRoute)
})

export default router
