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

import { AccountIsAlreadyVerifiedError, AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { accountIsAllowedToVerifyEmail } from '@models/account/verifyEmail'

const router = Router()

const rulesPost = [
  body('code').isNumeric()
]

router.post('/account/verify-email/', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  if (req.session.account.isVerified) {
    handleErrorOnRoute(res)(new AccountIsAlreadyVerifiedError())
    return
  }
  accountIsAllowedToVerifyEmail(req.session.account.id, req.body.code).then(async (isAllowed: boolean) => {
    if (!isAllowed) {
      logger.error('Account is not allowed to verify email.')
      res.status(StatusCodes.FORBIDDEN).send(getReasonPhrase(StatusCodes.FORBIDDEN))
      return
    }
    await modifyAccount(req.session.account!.id, { isVerified: true }).then(async () => {
      await mapAccountToSession(req)
    }).then(() => {
      res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
    }).catch((err) => { throw err })
  }).catch(handleErrorOnRoute(res))
})

export default router
