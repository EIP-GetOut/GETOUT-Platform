/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Router } from 'express'
import { type Request, type Response } from 'express'
import { body, type CustomValidator } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import {
  preloadFirstRecommendations as preloadFirstBooksRecommendations,
  preloadNextRecommendations as preloadNextBooksRecommendations

} from '@services/recommendationsCaching/books'
import {
  preloadFirstRecommendations as preloadFirstMoviesRecommendations,
  preloadNextRecommendations as preloadNextMoviesRecommendations
} from '@services/recommendationsCaching/movies'
import { AccountDoesNotExistError, AuthenticationError, NotLoggedInError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { addPreferences, postPreferences } from '@models/account/preferences'
import { type Preferences } from '@models/account/preferences.interface'
import { generateRecommendationsFromScratch as generateBookRecommendationsFromScratch } from '@models/account/recommendBooks'
import { generateRecommendationsFromScratch as generateMovieRecommendationsFromScratch } from '@models/account/recommendMovies'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

const GENRES_TO_GOOGLE_BOOKS_GENRES: Record<string, string> = {
  Policier: 'crime',
  'Science-fiction': 'fiction',
  Politique: 'political',
  Poésie: 'poesy',
  Histoire: 'history',
  Science: 'science',
  Philosophie: 'philosophy',
  Biographie: 'biography',
  'Contes et légendes': 'tale',
  Roman: 'novel',
  Romance: 'romance',
  Suspence: 'suspence',
  'Autre genre': 'TODO'
}

const booksGenresValidator: CustomValidator = (value: string[]) => {
  for (const genre of value) {
    if (!Object.prototype.hasOwnProperty.call(GENRES_TO_GOOGLE_BOOKS_GENRES, genre)) {
      throw new Error(`Invalid genre: ${genre}. Allowed genres are ${Object.keys(GENRES_TO_GOOGLE_BOOKS_GENRES).join(', ')}.`)
    }
  }
  return true
}

const rulesPut = [
  body('moviesGenres')
    .isArray({ max: 3 })
    .withMessage('Movies genres must be an array with a maximum of 3 elements.')
    .custom((value) => {
      const allowedGenres = [
        28, 12, 16, 35, 80, 99, 18, 10751, 14, 36, 27, 10402, 9648, 10749, 878, 10770, 53, 10752, 37
      ]
      for (const genre of value) {
        if (!allowedGenres.includes(genre)) {
          throw new Error(`Invalid movie genre: ${genre}. Allowed genres are ${allowedGenres.join(', ')}.`)
        }
      }
      return true
    }),

  body('booksGenres')
    .isArray({ max: 3 })
    .withMessage('Books genres must be an array with a maximum of 3 elements.')
    .custom(booksGenresValidator),

  body('platforms')
    .isArray()
    .withMessage('Platforms must be an array.')
]
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
    req.body.booksGenres[index] = GENRES_TO_GOOGLE_BOOKS_GENRES[bookGenre]
  })
  const accountId = req.session.account.id
  addPreferences(accountId, req.body, 'preferences').then(async (preferencesAdded: Preferences) => {
    req.session.account!.preferences = preferencesAdded
    await modifyAccount(accountId, { preferences: preferencesAdded }).then(async () => {
      await mapAccountToSession(req)
    }).then(() => {
      return res.status(StatusCodes.OK).json(preferencesAdded)
    }).then(async () => {
      await Promise.all([
        preloadNextMoviesRecommendations(accountId),
        preloadNextBooksRecommendations(accountId)
      ])
    })
  }).catch(handleErrorOnRoute(res))
})

router.post('/account/preferences', rulesPut, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }

  const accountId = req.session.account.id
  let preferencesAdded: Preferences

  req.body.booksGenres.forEach((bookGenre: string, index: number) => {
    req.body.booksGenres[index] = GENRES_TO_GOOGLE_BOOKS_GENRES[bookGenre]
  })
  postPreferences(accountId, req.body, 'preferences').then(async (res: Preferences) => {
    preferencesAdded = res
  }).then(async () => {
    logger.info(`Preferences created: ${JSON.stringify(req.body, null, 0)}`)
  }).then(async () => {
    await Promise.all([
      generateMovieRecommendationsFromScratch(req, res, accountId),
      generateBookRecommendationsFromScratch(req, res, accountId)
    ])
  }).then(async () => {
    return await modifyAccount(accountId, { preferences: preferencesAdded })
  }).then(() => {
    return res.status(StatusCodes.CREATED).json(preferencesAdded)
  }).then(async () => {
    await Promise.all([
      preloadFirstMoviesRecommendations(accountId),
      preloadFirstBooksRecommendations(accountId)
    ])
  }).then(async () => {
    await modifyAccount(accountId, { lastBookRecommandation: new Date(), lastMovieRecommandation: new Date() })
  }).catch(handleErrorOnRoute(res))
})

export default router
