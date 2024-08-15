/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'
import { type Request, type Response } from 'express'
import { type Options, PythonShell } from 'python-shell'

import { type BookResponse, getBook } from '@services/googlebooks/getBook'
import logger from '@services/middlewares/logging'
import { setCurrentRecommendations } from '@services/recommendationsCaching/books'
import { AccountDoesNotExistError, AppError, DbError, RecommendationsDetailsError } from '@services/utils/customErrors'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

import { addRecommendedBooksToHistory } from './recommendationsHistory'

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

async function retreiveFullRecommendationsFromIds (ids: string []): Promise<BookResponse []> {
  return await Promise.all(ids.map(async (id) => (await getBook(id, false)))).catch((err: Error | AppError) => {
    if (err instanceof AppError) {
      throw err
    }
    throw new RecommendationsDetailsError(`Failed fetching recommendationsDetails (${err.name}: ${err.message})`)
  })
}

async function getRecommandationsFromHistory (id: UUID): Promise<BookResponse []> {
  return await findEntity<Account>('Account', { id }).then(async (account: Account | null) => {
    if (account?.recommendedBooksHistory == null) {
      throw new DbError('Recommended books history not found.')
    }
    const ids = account.recommendedBooksHistory.slice(-5)
    return await Promise.all(ids.map(async (id) => (await getBook(id, false)))).catch((err: Error | AppError) => {
      if (err instanceof AppError) {
        throw err
      }
      throw new RecommendationsDetailsError(`Failed fetching recommendationsDetails (${err.name}: ${err.message})`)
    })
  })
}

async function generateRecommendationsFromScratch (req: Request, res: Response, userId: UUID): Promise<BookResponse[]> {
  let recommendations: BookRecommandationAlgorithmResonse []
  let fullRecommendations: BookResponse []

  return await generateBooksRecommendations(userId).then(async (res) => {
    recommendations = res
    await addRecommendedBooksToHistory(recommendations, userId)
  }).then(async () => {
    return await retreiveFullRecommendationsFromIds(recommendations.map((recommendation) => recommendation.id))
  }).then(async (res) => {
    fullRecommendations = res
    await setCurrentRecommendations(userId, fullRecommendations)
  }).then(async () => {
    await modifyAccount(userId, { lastBookRecommandation: new Date() })
  }).then(async () => {
    logger.info(`Successfully retrieved book recommendations: ${JSON.stringify(recommendations, null, 2)}`)
    await mapAccountToSession(req)
  }).then(() => {
    return fullRecommendations
  })
}

export {
  generateBooksRecommendations,
  generateRecommendationsFromScratch,
  getRecommandationsFromHistory,
  retreiveFullRecommendationsFromIds
}
