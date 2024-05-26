/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import { NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { deleteAccount } from '@models/account'

const router = Router()

router.delete('/account', logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  deleteAccount(req.session).then(() => {
    return res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  }).catch(handleErrorOnRoute(res))
})

export default router
