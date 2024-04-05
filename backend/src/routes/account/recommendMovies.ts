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
import { NotLoggedInError, PreferencesDoesNotExistError, RecommendationsDetailsError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { addRecommendedMoviesToHistory } from '@models/account/recommendationsHistory'
import { getMovie } from '@models/movie'

const router = Router()

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

  PythonShell.run('movies.py', options).then(async ([output]: any) => {
    const recommendations = output.recommendations
    const promisesArray: Array<Promise<any>> = []

    recommendations.forEach((recommandation: any) => {
      promisesArray.push(getMovie(recommandation.id))
    })

    await addRecommendedMoviesToHistory(recommendations, req.session.account!.id).then(async (): Promise<any []> => {
      return await Promise.all(promisesArray)
    }).catch(() => {
      throw new RecommendationsDetailsError()
    }).then((resolvedPromises) => {
      logger.info(`Successfully retreived movie recommendations: ${JSON.stringify(recommendations, null, 2)}`)
      return res.status(StatusCodes.OK).json(resolvedPromises)
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
