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

import { modifyAccount } from '@models/account'
import { addPreferences, postPreferences } from '@models/account/preferences'
import { type Preferences } from '@models/account/preferences.intefaces'

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
  addPreferences(req.session.account.id, req.body, 'preferences').then(async (preferencesAdded: Preferences) => {
    req.session.account!.preferences = preferencesAdded
    return await modifyAccount(req.session.account!.id, { preferences: preferencesAdded }).then(() => {
      return res.status(StatusCodes.OK).json(preferencesAdded)
    })
  }).catch(handleErrorOnRoute(res))
})

router.post('/account/preferences', rulesPut, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  postPreferences(req.session.account.id, req.body, 'preferences').then(async (preferencesAdded: Preferences) => {
    return await modifyAccount(req.session.account!.id, { preferences: preferencesAdded }).then(() => {
      logger.info(`Preferences created: ${JSON.stringify(req.body, null, 0)}`)
      return res.status(StatusCodes.CREATED).json(preferencesAdded)
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
