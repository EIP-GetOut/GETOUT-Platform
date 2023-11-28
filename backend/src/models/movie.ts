/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Théo de Boysson <theo.de-boysson@epitech.eu>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'
import { MovieDb, type MovieResponse } from 'moviedb-promise'

import logger from '@middlewares/logging'

import { AccountDoesNotExistError, DbError, MovieDbError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { type MovieDTO } from '@routes/movie.dto'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

const moviedb = new MovieDb('1eec31e851e9ad1b8f3de3ccf39953b7')

async function getDetail (params: MovieDTO): Promise<MovieResponse | undefined> {
  return await moviedb.movieInfo(params.id).then((value: MovieResponse) => {
    logger.info(JSON.stringify(value, null, 2))
    return value
  }).catch((err: Error) => {
    throw new MovieDbError(err.message)
  })
}

async function addMovieToWatchlist (accountId: UUID, movieId: number): Promise<number[]> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (!account.watchlist.includes(movieId)) {
      account.watchlist.push(movieId)
    }
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount) => {
    if (savedAccount == null) {
      throw new DbError('Failed adding movie to the watchlist.')
    }
    return savedAccount.watchlist
  })
}

export { addMovieToWatchlist, getDetail }
