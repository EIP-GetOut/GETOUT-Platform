/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type UUID } from 'crypto'
import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'
import { type Options, PythonShell } from 'python-shell'

import logger, { logApiRequest } from '@services/middlewares/logging'
import { AccountDoesNotExistError, AppError, DbError, NotLoggedInError, PreferencesDoesNotExistError, RecommendationsDetailsError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { addRecommendedMoviesToHistory } from '@models/account/recommendationsHistory'
import { findEntity } from '@models/getObjects'
import { getMovie } from '@models/movie'

import { Account } from '@entities/Account'

const router = Router()

async function getRecommandationsFromHistory (id: UUID): Promise<any> {
  return await findEntity<Account>('Account', { id }).then(async (account: Account | null) => {
    if (account?.recommendedMoviesHistory == null) {
      throw new DbError('Recommended movies history not found.')
    }
    return await Promise.all(account?.recommendedMoviesHistory.slice(-5).map(getMovie)).catch(() => {
      throw new RecommendationsDetailsError()
    })
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

  logger.debug(`Missing ${(60000 - (Date.now() - new Date(req.session.account!.lastMovieRecommandation!).getTime())) / 1000} seconds to generate new recommendations.`)

  if (req.session.account?.lastMovieRecommandation != null &&
    Date.now() - new Date(req.session.account.lastMovieRecommandation).getTime() < 60000) { // 1 minutes
    getRecommandationsFromHistory(req.session.account.id).then((resolvedPromises) => {
      logger.info('Successfully retrieved last 5 recommendations.')
      return res.status(StatusCodes.OK).json(resolvedPromises)
    }).catch(handleErrorOnRoute(res))
    return
  }

  findEntity<Account>(Account, { id: req.session.account!.id }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    const options: Options = {
      mode: 'text',
      pythonPath: '/usr/bin/python3',
      pythonOptions: [],
      scriptPath: 'src/services/recommendations/movies/',
      args: [JSON.stringify(account)],
      env: process.env
    }
    logger.debug(`Parameters of the recommendation: ${JSON.stringify(account)}`)

    await PythonShell.run('movies.py', options).then(async (output: any) => {
      const promisesArray: Array<Promise<any>> = []
      const recommendations: any[] = JSON.parse(output[0]).slice(0, 5)

      recommendations.forEach((recommandation: any) => {
        promisesArray.push(getMovie(recommandation.id))
      })

      return await addRecommendedMoviesToHistory(recommendations, req.session.account!.id).then(async (): Promise<any []> => {
        return await Promise.all(promisesArray)
      }).catch(() => {
        throw new RecommendationsDetailsError()
      }).then(async (resolvedPromises) => {
        return await modifyAccount(req.session.account!.id, { lastMovieRecommandation: new Date() }).then(async () => {
          logger.info(`Successfully retrieved movie recommendations: ${JSON.stringify(recommendations, null, 2)}`)
          await mapAccountToSession(req)
        }).then(() => {
          return res.status(StatusCodes.OK).json(resolvedPromises)
        })
      })
    })
  }).catch((err: any) => {
    if (req.session.account?.lastMovieRecommandation != null && !(err instanceof AppError)) {
      getRecommandationsFromHistory(req.session.account.id).then((resolvedPromises) => {
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
