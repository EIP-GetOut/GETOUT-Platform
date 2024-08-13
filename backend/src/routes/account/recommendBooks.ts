/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type UUID } from 'crypto'
import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'

import { getCurrentRecommendations, getNextRecommendations, preloadNextRecommendations, setCurrentRecommendations } from '@services/recommendationsCaching/books'
import { AppError, NotLoggedInError, PreferencesDoesNotExistError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { addRecommendedBooksToHistory } from '@models/account/recommendationsHistory'
import {
  generateRecommendationsFromScratch,
  getRecommandationsFromHistory
} from '@models/account/recommendBooks'

const router = Router()

function fancyRecommendationErrorCatcher (req: Request, res: Response, accountId: UUID, err: any): void {
  if (req.session.account?.lastBookRecommandation != null && !(err instanceof AppError)) {
    getRecommandationsFromHistory(accountId).then((resolvedPromises) => {
      logger.error(`${err.name}: ${err.message}`)
      logger.info('Unknown error detected, retrieved last 5 recommendations from history.')
      return res.status(StatusCodes.OK).json(resolvedPromises)
    }).catch(handleErrorOnRoute(res))
  } else {
    handleErrorOnRoute(res)(err)
  }
}

router.get('/account/:accountId/recommend-books', logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  if (req.session.account?.preferences == null) {
    handleErrorOnRoute(res)(new PreferencesDoesNotExistError())
    return
  }

  const accountId = req.session.account.id
  const interval = process.env.RECOMMENDATIONS_INTERVAL_SECONDS * 1000
  const lastBookRecommandation = req.session.account.lastBookRecommandation

  if (lastBookRecommandation == null) {
    logger.info('Last book recommendation does not exist, generating new recommendations from scratch.')
    generateRecommendationsFromScratch(req, res, accountId).then((recommendations) => {
      return res.status(StatusCodes.OK).json(recommendations)
    }).then(async () => {
      if (process.env.NODE_ENV !== 'test') {
        await preloadNextRecommendations(accountId).catch((err: Error) => {
          logger.error(`${err.name}: ${err.message}`)
        })
      }
    }).catch((err) => { fancyRecommendationErrorCatcher(req, res, accountId, err) })
    return
  }

  if (Date.now() - new Date(lastBookRecommandation).getTime() >= interval) {
    getNextRecommendations(accountId).then(async (nextRecommendations): Promise<void> => {
      if (nextRecommendations !== null) {
        await setCurrentRecommendations(accountId, nextRecommendations).then(async () => {
          return await addRecommendedBooksToHistory(nextRecommendations, accountId)
        }).then(async () => {
          await modifyAccount(accountId, { lastBookRecommandation: new Date() })
        }).then(async () => {
          return await mapAccountToSession(req)
        }).then(() => {
          logger.info('Successfully retreived next recommendations from cache.')
          res.status(StatusCodes.OK).json(nextRecommendations)
        })
      } else {
        logger.info('Couldn\'t retreive next recommendations from cache, generating new recommendations from scratch.')
        await generateRecommendationsFromScratch(req, res, accountId).then((recommendations) => {
          return res.status(StatusCodes.OK).json(recommendations)
        })
      }
    }).then(async () => {
      if (process.env.NODE_ENV !== 'test') {
        await preloadNextRecommendations(accountId).catch((err: Error) => {
          logger.error(`${err.name}: ${err.message}`)
        })
      }
    }).catch((err) => { fancyRecommendationErrorCatcher(req, res, accountId, err) })
  } else {
    logger.debug(`Missing ${(interval - (Date.now() - new Date(lastBookRecommandation).getTime())) / 1000} seconds to generate new recommendations.`)
    logger.info('Retreiving current recommendations from cache.')
    getCurrentRecommendations(accountId).then(async (cachedRecommendations): Promise<void> => {
      if (cachedRecommendations !== null && Date.now() - new Date(lastBookRecommandation).getTime() < interval) {
        logger.info('Successfully retrieved last 5 recommendations from cache.')
        res.status(StatusCodes.OK).json(cachedRecommendations)
      } else {
        await generateRecommendationsFromScratch(req, res, accountId).then((recommendations) => {
          return res.status(StatusCodes.OK).json(recommendations)
        })
      }
    }).catch((err) => { fancyRecommendationErrorCatcher(req, res, accountId, err) }).then(async () => {
      await getNextRecommendations(accountId)
    }).then(async (nextRecommendations) => {
      nextRecommendations == null && await preloadNextRecommendations(accountId)
    }).catch((err: Error) => {
      logger.error(`${err.name}: ${err.message}`)
    })
  }
})

export default router
