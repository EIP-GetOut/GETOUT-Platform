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
// import nodemailer, { type SentMessageInfo } from 'nodemailer'
// import type Mail from 'nodemailer/lib/mailer'
import type SMTPTransport from 'nodemailer/lib/smtp-transport'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

// import { NodeMailerError } from '@services/utils/customErrors'

import { generateResetPasswordUrl } from '@models/account/password'

// import { emailConfig } from '@config/emailConfig'

const router = Router()

const rulesPost = [
  body('email').isEmail(),
  body('firstName').isString(),
  body('lastName').isString()
]

async function sendEmail (body: any, resetPasswordUrl: string): Promise<SMTPTransport.SentMessageInfo> {
  // const mailOptions: Mail.Options = {
  //   from: emailConfig.auth?.user,
  //   to: body.email,
  //   subject: 'Subject of the Email',
  //   text: `<p>Hello my friend ${body.firstName} ${body.lastName}: ${process.env.ORIGIN}${resetPasswordUrl}</p>`
  // }
  // const transporter = nodemailer.createTransport(emailConfig)

  const example: SMTPTransport.SentMessageInfo = {
    envelope: { from: 'mailOptions.from', to: ['mailOptions.to'] },
    accepted: ['true'],
    messageId: '',
    pending: [''],
    rejected: [''],
    response: ''
  }
  logger.debug(`Sending email: "Hello my friend ${body.firstName} ${body.lastName}: ${resetPasswordUrl}".`)
  return await Promise.resolve(example)
  // return await transporter.sendMail(mailOptions).then(async (info: SentMessageInfo): Promise<SentMessageInfo> => {
  //   console.log('Email sent: ', info)
  //   return info
  // }).catch((err) => {
  //   throw new NodeMailerError(`Failed sending email (${err.name}: ${err.message})`)
  // })
}

router.post('/account/reset-password/send-email', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  generateResetPasswordUrl(req.session?.account?.id as UUID, req.body.email).then(async (url) => {
    return await sendEmail(req.body, url).then((sendEmailRes) => {
      // if (!sendEmailRes.ok) {
      //   throw Error(`Failed sending reset password email: ${sendEmailRes.statusText}`)
      // }
      return res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
    })
  }).catch((err) => {
    logger.error(err.toString())
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR)
      .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
  })
})

export default router
