/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { type Request, type Response, Router } from 'express'
import { query } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { accountIsAllowedToResetPassword } from '@models/account/password'

const router = Router()

const rulesGet = [
  query('token').isString(),
  query('password').isNumeric()
]

router.get('/account/reset-password/is-allowed', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  accountIsAllowedToResetPassword(req.query.token as string, parseInt(req.query.password as string)).then((isAllowed: boolean) => {
    if (!isAllowed) {
      logger.error('Account is not allowed to reset password.')
      res.status(StatusCodes.FORBIDDEN).send(getReasonPhrase(StatusCodes.FORBIDDEN))
      return
    }
    return res.status(StatusCodes.OK).send(true)
  }).catch(handleErrorOnRoute(res))
})

export default router
