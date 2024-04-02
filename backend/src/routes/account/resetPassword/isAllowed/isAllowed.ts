/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { type Request, type Response, Router } from 'express'
import { query } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { accountIsAllowedToResetPassword } from '@models/account/password'

const router = Router()

const rulesGet = [
  query('code').isNumeric()
]

router.get('/account/reset-password/is-allowed', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  accountIsAllowedToResetPassword(parseInt(req.query.code as string)).then((isAllowed: boolean) => {
    return res.status(StatusCodes.OK).send(isAllowed)
  }).catch(handleErrorOnRoute(res))
})

export default router
