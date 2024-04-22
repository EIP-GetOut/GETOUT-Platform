/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'
import { type Options, PythonShell } from 'python-shell'

import logger, { logApiRequest } from '@services/middlewares/logging'
import { type SessionAccount } from '@services/utils/appUtils/useSession'
import { AppError, NotLoggedInError, PreferencesDoesNotExistError, RecommendationsDetailsError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { modifyAccount } from '@models/account'
import { addRecommendedMoviesToHistory } from '@models/account/recommendationsHistory'
import { getMovie } from '@models/movie'

const router = Router()

async function getRecommandationsFromHistory (account: SessionAccount): Promise<any> {
  return await Promise.all(account?.recommendedMoviesHistory.slice(-5).map(getMovie)).catch(() => {
    throw new RecommendationsDetailsError()
  })
}

// TODO refacto too big route
router.get('/account/:accountId/recommend-movies', logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
  }
  if (req.session.account?.preferences == null) {
    handleErrorOnRoute(res)(new PreferencesDoesNotExistError())
  }

  const options: Options = {
    mode: 'json',
    pythonPath: '/usr/bin/python3',
    pythonOptions: [],
    scriptPath: 'src/services/recommendations/',
    args: [JSON.stringify(req.session.account)],
    env: process.env
  }

  logger.debug(`Missing ${(60000 - (Date.now() - new Date(req.session.account!.lastRecommandation!).getTime())) / 1000} seconds to generate new recommendations.`)

  if (req.session.account?.lastRecommandation != null &&
    Date.now() - new Date(req.session.account.lastRecommandation).getTime() < 60000) { // 1 minutes
    getRecommandationsFromHistory(req.session.account).then((resolvedPromises) => {
      logger.info('Successfully retrieved last 5 recommendations.')
      return res.status(StatusCodes.OK).json(resolvedPromises)
    }).catch(handleErrorOnRoute(res))
    return
  }

  PythonShell.run('movies.py', options).then(async ([output]: any) => {
    const recommendations = output.recommendations
    const promisesArray: Array<Promise<any>> = []

    recommendations.forEach((recommandation: any) => {
      promisesArray.push(getMovie(recommandation.id))
    })

    return await addRecommendedMoviesToHistory(recommendations, req.session.account!.id).then(async (): Promise<any []> => {
      return await Promise.all(promisesArray)
    }).catch(() => {
      throw new RecommendationsDetailsError()
    }).then(async (resolvedPromises) => {
      return await modifyAccount(req.session.account!.id, { lastRecommandation: new Date() }).then(() => {
        logger.info(`Successfully retrieved movie recommendations: ${JSON.stringify(recommendations, null, 2)}`)
        return res.status(StatusCodes.OK).json(resolvedPromises)
      })
    })
  }).catch((err: any) => {
    if (req.session.account?.lastRecommandation != null && !(err instanceof AppError)) {
      getRecommandationsFromHistory(req.session.account).then((resolvedPromises) => {
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
