/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'
import { type Options, PythonShell } from 'python-shell'

import logger from '@services/middlewares/logging'
import { AccountDoesNotExistError, DbError, RecommendationsDetailsError } from '@services/utils/customErrors'

import { findEntity } from '@models/getObjects'
import { getMovie } from '@models/movie'

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

async function retreiveFullRecommendationsFromIds (ids: number []): Promise<any []> {
  return await Promise.all(ids.map(getMovie)).catch(() => {
    throw new RecommendationsDetailsError()
  })
}

async function getRecommandationsFromHistory (accountId: UUID): Promise<any> {
  return await findEntity<Account>('Account', { id: accountId }).then(async (account: Account | null) => {
    if (account?.recommendedMoviesHistory == null) {
      throw new DbError('Recommended movies history not found.')
    }
    return await Promise.all(account?.recommendedMoviesHistory.slice(-5).map(getMovie)).catch(() => {
      throw new RecommendationsDetailsError()
    })
  })
}

export {
  generateMoviesRecommendations,
  getRecommandationsFromHistory,
  retreiveFullRecommendationsFromIds
}
