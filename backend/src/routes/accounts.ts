/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Router } from 'express'
import { type Request, type Response } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'
import { type UUID } from 'node:crypto'

import { logApiRequest } from '@services/middlewares/logging'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { deleteAccountById, getAccounts } from '@models/accounts'

const router = Router()

router.get('/accounts/:page', logApiRequest, (req: Request, res: Response) => {
  getAccounts(parseInt(req.params.page, 10)).then(async (accounts: any) => {
    // logger.info(`Successfully retreived 50 accounts at page ${req.params.page}`)
    return res.status(StatusCodes.OK).json({ accounts })
  }).catch(handleErrorOnRoute(res))
})

router.delete('/accounts/:id', logApiRequest, (req: Request, res: Response) => {
  deleteAccountById(req.params.id as UUID).then(() => {
    return res.status(StatusCodes.NO_CONTENT).send(getReasonPhrase(StatusCodes.NO_CONTENT))
  }).catch(handleErrorOnRoute(res))
})

export default router
