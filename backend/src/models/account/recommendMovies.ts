/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'
import { type Request, type Response } from 'express'
import { type Options, PythonShell } from 'python-shell'

import logger from '@services/middlewares/logging'
import { setCurrentRecommendations } from '@services/recommendationsCaching/movies'
import { type MovieResponse, getMovie } from '@services/tmdb/getMovie'
import { AccountDoesNotExistError, AppError, DbError, RecommendationsDetailsError } from '@services/utils/customErrors'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { addRecommendedMoviesToHistory } from '@models/account/recommendationsHistory'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

export interface MovieRecommandationAlgorithmResonse {
  id: number
  title: string
  score: number
}

async function generateMoviesRecommendations (userId: UUID): Promise<MovieRecommandationAlgorithmResonse []> {
  return await findEntity<Account>(Account, { id: userId }).then(async (account: Account | null) => {
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

    return await PythonShell.run('movies.py', options).then(async (output: any) => {
      const recommendations: MovieRecommandationAlgorithmResonse [] = JSON.parse(output[0]).slice(0, 5)
      return recommendations
    })
  })
}

async function retreiveFullRecommendationsFromIds (ids: number []): Promise<MovieResponse []> {
  return await Promise.all(ids.map(getMovie)).then((movieResponse: MovieResponse []) => {
    return movieResponse
  }).catch((err: Error | AppError) => {
    if (err instanceof AppError) {
      throw err
    }
    throw new RecommendationsDetailsError(`Failed fetching recommendationsDetails (${err.name}: ${err.message})`)
  })
}

async function getRecommandationsFromHistory (accountId: UUID): Promise<MovieResponse []> {
  return await findEntity<Account>('Account', { id: accountId }).then(async (account: Account | null) => {
    if (account?.recommendedMoviesHistory == null) {
      throw new DbError('Recommended movies history not found.')
    }
    return await Promise.all(account?.recommendedMoviesHistory.slice(-5).map(getMovie)).catch((err: Error | AppError) => {
      if (err instanceof AppError) {
        throw err
      }
      throw new RecommendationsDetailsError(`Failed fetching recommendationsDetails (${err.name}: ${err.message})`)
    })
  })
}

async function generateRecommendationsFromScratch (req: Request, res: Response, userId: UUID): Promise<MovieResponse[]> {
  let recommendations: MovieRecommandationAlgorithmResonse []
  let fullRecommendations: MovieResponse []

  return await generateMoviesRecommendations(userId).then(async (res) => {
    recommendations = res
    await addRecommendedMoviesToHistory(recommendations, userId)
  }).then(async () => {
    return await retreiveFullRecommendationsFromIds(recommendations.map((recommendation) => recommendation.id))
  }).then(async (res) => {
    fullRecommendations = res
    await setCurrentRecommendations(userId, fullRecommendations)
  }).then(async () => {
    await modifyAccount(userId, { lastMovieRecommandation: new Date() })
  }).then(async () => {
    logger.info(`Successfully retrieved movie recommendations: ${JSON.stringify(recommendations, null, 2)}`)
    await mapAccountToSession(req)
  }).then(() => {
    return fullRecommendations
  })
}

export {
  generateMoviesRecommendations,
  generateRecommendationsFromScratch,
  getRecommandationsFromHistory,
  retreiveFullRecommendationsFromIds
}
