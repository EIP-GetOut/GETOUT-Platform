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

import { getBook } from '@models/book'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

export interface BookRecommandationAlgorithmResonse {
  id: string
  title: string
  score: number
}

async function generateBooksRecommendations (userId: UUID): Promise<BookRecommandationAlgorithmResonse []> {
  return await findEntity<Account>(Account, { id: userId }).then(async (account: Account | null) => {
    if (account == null) {
      throw new AccountDoesNotExistError()
    }
    const options: Options = {
      mode: 'text',
      pythonPath: '/usr/bin/python3',
      pythonOptions: [],
      scriptPath: 'src/services/recommendations/books/',
      args: [JSON.stringify(account)],
      env: process.env
    }
    logger.debug(`Parameters of the recommendation: ${JSON.stringify(account)}`)

    return await PythonShell.run('books.py', options).then(async (output: any) => {
      const recommendations: BookRecommandationAlgorithmResonse [] = JSON.parse(output[0]).slice(0, 5)
      return recommendations
    })
  })
}

async function retreiveFullRecommendationsFromIds (ids: string []): Promise<any []> {
  return await Promise.all(ids.map(async (id) => (await getBook(id, false)))).catch(() => {
    throw new RecommendationsDetailsError()
  })
}

async function getRecommandationsFromHistory (id: UUID): Promise<any> {
  return await findEntity<Account>('Account', { id }).then(async (account: Account | null) => {
    if (account?.recommendedBooksHistory == null) {
      throw new DbError('Recommended books history not found.')
    }
    const ids = account.recommendedBooksHistory.slice(-5)
    return await Promise.all(ids.map(async (id) => (await getBook(id, false)))).catch(() => {
      throw new RecommendationsDetailsError()
    })
  })
}

export {
  generateBooksRecommendations,
  getRecommandationsFromHistory,
  retreiveFullRecommendationsFromIds
}
