/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Request, Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@middlewares/logging'
import validate from '@middlewares/validator'

const router = Router()

const rules = [
]

router.get('/session', rules, validate, logApiRequest, (req: Request, res: Response) => {
  res.status(StatusCodes.OK).json(req.session)
})

export default router
