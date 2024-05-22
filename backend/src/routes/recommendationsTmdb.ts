/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger from '@middlewares/logging'

import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getRecommendation } from '@models/movie'

const router = Router()

router.get('/recommendationTmdb/:id', validate, logApiRequest, (req: Request, res: Response) => {
  getRecommendation(parseInt(req.params.id)).then(async (recommendations: any) => {
    logger.info(`Successfully retreived recommendations ${req.params.id}: ${JSON.stringify(recommendations, null, 2)}`)
    return res.status(StatusCodes.OK).json({ recommendations })
  }).catch(handleErrorOnRoute(res))
})

export default router
