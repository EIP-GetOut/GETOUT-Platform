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

import { AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { accountIsAllowedToVerifyEmail, verifyEmail } from '@models/account/verifyEmail'

const router = Router()

const rulesPost = [
  body('code').isNumeric()
]

router.post('/account/verify-email/', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  accountIsAllowedToVerifyEmail(req.session.account?.id, req.body.code).then((isAllowed: boolean): void => {
    if (!isAllowed) {
      logger.error('Account is not allowed to verify email.')
      res.status(StatusCodes.FORBIDDEN).send(getReasonPhrase(StatusCodes.FORBIDDEN))
      return
    }
    verifyEmail(req.session.account!.id).then(() => {
      res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
    }).catch(handleErrorOnRoute(res))
  }).catch(handleErrorOnRoute(res))
})

export default router