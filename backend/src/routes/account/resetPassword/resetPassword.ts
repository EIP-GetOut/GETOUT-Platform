/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { accountIsAllowedToResetPassword, changeAccountPasswordFromCode } from '@models/account/password'

const router = Router()

const rulesPost = [
  body('code').isNumeric(),
  body('newPassword').isString()
]

router.post('/account/reset-password/', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  accountIsAllowedToResetPassword(req.body.code).then((isAllowed: boolean): void => {
    if (!isAllowed) {
      logger.error('Account is not allowed to reset password.')
      res.status(StatusCodes.FORBIDDEN).send(getReasonPhrase(StatusCodes.FORBIDDEN))
      return
    }
    changeAccountPasswordFromCode(req.body.code, req.body.newPassword).then(() => {
      res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
    }).catch(handleErrorOnRoute(res))
  }).catch(handleErrorOnRoute(res))
})

export default router
