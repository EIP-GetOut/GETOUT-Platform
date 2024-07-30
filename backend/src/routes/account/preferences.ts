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
import { AccountDoesNotExistError, AuthenticationError, NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { addPreferences, postPreferences } from '@models/account/preferences'
import { type Preferences } from '@models/account/preferences.interface'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

const rulesPut = [
  body('moviesGenres').isArray({ max: 3 }),
  body('booksGenres').isArray({ max: 3 }),
  body('platforms').isArray()
]

const BOOKS_GENRES_TO_GOOGLE_BOOKS_GENRES: Record<string, string> = {
  Policier: 'crime',
  'Science-fiction': 'fiction',
  Politique: 'political',
  Poésie: 'poesy',
  Histoire: 'history',
  Science: 'science',
  Philosophie: 'philosophy',
  Biographie: 'biography',
  'Contes et légendes': 'tale',
  Romance: 'romance',
  'Autre genre': 'TODO'
}

/**
 * @swagger
 * /account/preferences:
 *   get:
 *     summary: Get account preferences
 *     description: Retrieve the preferences for the currently authenticated account.
 *     responses:
 *       200:
 *         description: Account preferences retrieved successfully
 *         schema:
 *               type: object
 *               properties:
 *                 platforms:
 *                   type: array
 *                   items:
 *                     type: string
 *                   description: List of platforms
 *                   example: ["PrimeVideo"]
 *                 booksGenres:
 *                   type: array
 *                   items:
 *                     type: string
 *                   description: List of favorite book genres
 *                   example: ["philosophy", "romance"]
 *                 moviesGenres:
 *                   type: array
 *                   items:
 *                     type: integer
 *                   description: List of favorite movie genres (represented by IDs)
 *                   example: [28, 12, 16]
 *       401:
 *         description: Unauthorized - User must be connected
 *         schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: User must be connected.
 *       500:
 *         description: Internal server error
 *         schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: Account does not exist.
 */

router.get('/account/preferences', logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  findEntity<Account>(Account, { id: req.session.account.id }).then((account: Account | null) => {
    if (account === null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.INTERNAL_SERVER_ERROR)
    }
    return res.status(StatusCodes.OK).json(account.preferences)
  }).catch(handleErrorOnRoute(res))
})

router.put('/account/preferences', rulesPut, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  req.body.booksGenres.forEach((bookGenre: string, index: number) => {
    req.body.booksGenres[index] = BOOKS_GENRES_TO_GOOGLE_BOOKS_GENRES[bookGenre]
  })
  addPreferences(req.session.account.id, req.body, 'preferences').then(async (preferencesAdded: Preferences) => {
    req.session.account!.preferences = preferencesAdded
    return await modifyAccount(req.session.account!.id, { preferences: preferencesAdded }).then(async () => {
      await mapAccountToSession(req)
    }).then(() => {
      return res.status(StatusCodes.OK).json(preferencesAdded)
    })
  }).catch(handleErrorOnRoute(res))
})

router.post('/account/preferences', rulesPut, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  req.body.booksGenres.forEach((bookGenre: string, index: number) => {
    req.body.booksGenres[index] = BOOKS_GENRES_TO_GOOGLE_BOOKS_GENRES[bookGenre]
  })
  postPreferences(req.session.account.id, req.body, 'preferences').then(async (preferencesAdded: Preferences) => {
    return await modifyAccount(req.session.account!.id, { preferences: preferencesAdded }).then(async () => {
      logger.info(`Preferences created: ${JSON.stringify(req.body, null, 0)}`)
      await mapAccountToSession(req)
    }).then(() => {
      return res.status(StatusCodes.CREATED).json(preferencesAdded)
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
