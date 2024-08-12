/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@middlewares/logging'

import { AppError, NotLoggedInError, PreferencesDoesNotExistError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { addRecommendedBooksToHistory } from '@models/account/recommendationsHistory'
import {
  generateBooksRecommendations,
  getRecommandationsFromHistory,
  retreiveFullRecommendationsFromIds
} from '@models/account/recommendBooks'

const router = Router()

router.get('/account/:accountId/recommend-books', logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
  }
  if (req.session.account?.preferences == null) {
    handleErrorOnRoute(res)(new PreferencesDoesNotExistError())
  }

  logger.debug(`Missing ${(60000 - (Date.now() - new Date(req.session.account!.lastBookRecommandation!).getTime())) / 1000} seconds to generate new recommendations.`)

  if (req.session.account?.lastBookRecommandation != null &&
    Date.now() - new Date(req.session.account.lastBookRecommandation).getTime() < 60000) { // 1 minutes
    getRecommandationsFromHistory(req.session.account.id).then((resolvedPromises) => {
      logger.info('Successfully retrieved last 5 recommendations.')
      return res.status(StatusCodes.OK).json(resolvedPromises)
    }).catch(handleErrorOnRoute(res))
    return
  }

  generateBooksRecommendations(req.session.account!.id).then(async (recommendations) => {
    return await addRecommendedBooksToHistory(recommendations, req.session.account!.id).then(async () => {
      return await retreiveFullRecommendationsFromIds(recommendations.map((recommendation) => recommendation.id))
    }).then(async (resolvedPromises) => {
      return await modifyAccount(req.session.account!.id, { lastBookRecommandation: new Date() }).then(async () => {
        logger.info(`Successfully retrieved book recommendations: ${JSON.stringify(recommendations, null, 2)}`)
        await mapAccountToSession(req)
      }).then(() => {
        return res.status(StatusCodes.OK).json(resolvedPromises)
      })
    })
  }).catch((err: any) => {
    if (req.session.account?.lastBookRecommandation != null && !(err instanceof AppError)) {
      getRecommandationsFromHistory(req.session.account.id).then(async (resolvedPromises) => {
        logger.error(`${err.name}: ${err.message}`)
        logger.info('Unknown error detected, retrieved last 5 recommendations.')
        return res.status(StatusCodes.OK).json(resolvedPromises)
      }).catch(handleErrorOnRoute(res))
    } else {
      handleErrorOnRoute(res)(err)
    }
  })
})

export default router
