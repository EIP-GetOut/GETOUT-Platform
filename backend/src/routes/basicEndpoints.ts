/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Router, Request, Response } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import caching from '@middlewares/caching'
import logger, { logApiRequest } from '@middlewares/logging'


const router: Router = Router()

router.get('/', caching(24 * 60 * 60), logApiRequest, (req: Request, res: Response): void => {
  logger.info('Welcome to  GetOut API !')
  res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
})


router.use((req: Request, res: Response) => {
  logger.warn(`${req.method} ${req.url} : Route not found`)
  res.status(StatusCodes.NOT_FOUND)
    .send(getReasonPhrase(StatusCodes.NOT_FOUND))
})

router.use((err : Error, req: Request, res : Response) => {
  logger.error(err.stack)
  res.status(StatusCodes.INTERNAL_SERVER_ERROR)
    .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
})

export default router