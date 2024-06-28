/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response } from 'express'
import { Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { modifyNews } from '@models/news'

const router = Router()

const rulesPatch = [
  body('news1').optional(),
  body('news2').optional(),
  body('news3').optional(),
  body('news4').optional(),
  body('news5').optional()
]

router.patch('/news', rulesPatch, logApiRequest, (req: Request, res: Response) => {
  modifyNews(req.body).then(() => {
    return res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
  }).catch(handleErrorOnRoute(res))
})

export default router
