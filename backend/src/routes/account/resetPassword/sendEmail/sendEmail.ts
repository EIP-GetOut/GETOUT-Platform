/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { sendResetPasswordEmail } from '@services/brevo/emails'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { generatePasswordResetCode } from '@models/account/password'

const router = Router()

const rulesPost = [
  body('email').isEmail()
]

router.post('/account/reset-password/send-email', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  generatePasswordResetCode(req.body.email).then(async (passwordResetCode: number) => {
    return await sendResetPasswordEmail(req.body.email, passwordResetCode).then((sendEmailRes) => {
      return res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
    })
  }).catch(handleErrorOnRoute)
})

export default router
