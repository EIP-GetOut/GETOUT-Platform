/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getSessions } from '@models/sessions'

const router = Router()

router.get('/sessions', logApiRequest, (req: Request, res: Response) => {
  getSessions(req.sessionStore).then(async (nbSessions: any) => {
    logger.info('Successfully retreived the number of user connected.')
    return res.status(StatusCodes.OK).json({ nbSessions })
  }).catch(handleErrorOnRoute(res))
})

export default router
