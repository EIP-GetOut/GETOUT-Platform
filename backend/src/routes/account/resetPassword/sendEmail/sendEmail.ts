/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { type UUID } from 'crypto'
import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'
import type SMTPTransport from 'nodemailer/lib/smtp-transport'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { generatePasswordResetCode } from '@models/account/password'

const router = Router()

const rulesPost = [
  body('email').isEmail(),
  body('firstName').isString(),
  body('lastName').isString()
]

async function sendEmail (body: any, passwordResetCode: number): Promise<SMTPTransport.SentMessageInfo> {
  // const mailOptions: Mail.Options = {
  //   from: emailConfig.auth?.user,
  //   to: body.email,
  //   subject: 'Subject of the Email',
  //   text: `<p>Hello my friend ${body.firstName} ${body.lastName}: ${process.env.ORIGIN}${resetPasswordUrl}</p>`
  // }

  const example: SMTPTransport.SentMessageInfo = {
    envelope: { from: 'mailOptions.from', to: ['mailOptions.to'] },
    accepted: ['true'],
    messageId: '',
    pending: [''],
    rejected: [''],
    response: ''
  }
  logger.debug(`Sending email: "Hello my friend ${body.firstName} ${body.lastName}: ${passwordResetCode}".`)
  return await Promise.resolve(example)
}

router.post('/account/reset-password/send-email', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  generatePasswordResetCode(req.session?.account?.id as UUID, req.body.email).then(async (passwordResetCode: number) => {
    return await sendEmail(req.body, passwordResetCode).then((sendEmailRes) => {
      // if (!sendEmailRes.ok) {
      //   throw Error(`Failed sending reset password email: ${sendEmailRes.statusText}`)
      // }
      return res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
    })
  }).catch(handleErrorOnRoute)
})

export default router
