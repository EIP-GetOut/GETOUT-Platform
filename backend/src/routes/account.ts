/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { deleteAccount, modifyAccount } from '@models/account'

import { type Account } from '@entities/Account'

const router = Router()

const rulesPatch = [
  body('email').optional().isEmail(),
  body('firstName').optional().isString(),
  body('lastName').optional().isString(),
  body('bornDate').optional().isDate()
]

router.delete('/account', logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  deleteAccount(req.session).then(() => {
    return res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  }).catch(handleErrorOnRoute(res))
})

router.patch('/account', rulesPatch, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  modifyAccount(req.session.account.id, req.body as Partial<Account>).then(async () => {
    await mapAccountToSession(req)
  }).then(() => {
    return res.status(StatusCodes.OK).json(req.body)
  }).catch(handleErrorOnRoute)
})

export default router
