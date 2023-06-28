/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Request, Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { changeAccountPassword } from '@models/account/resetPassword'

const router = Router()

const rulesPost = [
  body('password').isString(),
  body('newPassword').isString()
]

router.post('/account/reset-password/', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (!req.session?.account?.id) {
    return res.status(StatusCodes.FORBIDDEN).send(getReasonPhrase(StatusCodes.FORBIDDEN))
  }
  return changeAccountPassword(req.session?.account?.id, req.body.password, req.body.newPassword).then((code: StatusCodes) => {
    return res.status(code).send(getReasonPhrase(code))
  }).catch((err) => {
    logger.error(err.toString())
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR)
      .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
  })
})

export default router
