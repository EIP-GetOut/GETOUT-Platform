/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Router } from 'express'
import { type Request, type Response } from 'express'
import { body } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { addPreferences, postPreferences } from '@models/account/preferences'

const router = Router()

const rulesPut = [
  body('moviesGenres').isArray(),
  body('booksGenres').isArray(),
  body('platforms').isArray()
]

router.put('/account/preferences', rulesPut, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  addPreferences(req.session.account.id, req.body, 'preferences').then((preferencesAdded: string[]) => {
    return res.status(StatusCodes.OK).json(preferencesAdded)
  }).catch(handleErrorOnRoute(res))
})

router.post('/account/preferences', rulesPut, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  logger.warn(JSON.stringify(req.body, null, 0))
  postPreferences(req.session.account.id, req.body, 'preferences').then((preferencesAdded: string[]) => {
    return res.status(StatusCodes.CREATED).json(preferencesAdded)
  }).catch(handleErrorOnRoute(res))
})

export default router
