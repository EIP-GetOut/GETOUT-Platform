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

import { AccountDoesNotExistError, DbError, MovieDbError, MovieNotInListError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { type MovieDTO } from '@routes/movie.dto'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

const moviedb = new MovieDb('1eec31e851e9ad1b8f3de3ccf39953b7')

// Function to fetch movie credits using moviedb-promise
async function fetchMovieCredits (movieId: any): Promise<any> {
  try {
    const credits = await moviedb.movieCredits({ id: movieId })

    // Extract information about the first 5 people in the credits
    const cast = credits.cast?.slice(0, 5).map(person => ({
      name: person.name,
      picture: ((person.profile_path ?? '').length > 0)
        ? `https://image.tmdb.org/t/p/w200${person.profile_path}`
        : null
    }))

    return cast
  } catch (error) {
    console.error('Error fetching movie credits:', error)
    return null
  }
}

async function getDetail (params: MovieDTO): Promise<MovieResponse | undefined> {
  return await moviedb.movieInfo(params.id).then((value: MovieResponse) => {
    logger.info(JSON.stringify(value, null, 2))
    return value
  }).catch((err: Error) => {
    throw new MovieDbError(err.message)
  })
}

async function addMovieToList (accountId: UUID, movieId: number, movieList: keyof Account): Promise<number[]> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (!(account[movieList] as number []).includes(movieId)) {
      (account[movieList] as number []).push(movieId)
    }
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount == null) {
      throw new DbError('Failed adding movie to the watchlist.')
    }
    return savedAccount[movieList] as number []
  })
}

async function removeMovieFromList (accountId: UUID, movieId: number, movieList: keyof Account): Promise<number[]> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (!(account[movieList] as number []).includes(movieId)) {
      throw new MovieNotInListError()
    }
    (account[movieList] as number []) = (account[movieList] as number []).filter(id => id !== movieId)
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount == null) {
      throw new DbError('Failed adding movie to the watchlist.')
    }
    return savedAccount[movieList] as number []
  })
}

const addMovieToWatchlist = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await addMovieToList(accountId, movieId, 'watchlist')

const addMovieToLikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await addMovieToList(accountId, movieId, 'likedMovies')

const addMovieToDislikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await addMovieToList(accountId, movieId, 'dislikedMovies')

const removeMovieFromWatchlist = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'watchlist')

const removeMovieFromLikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'likedMovies')

const removeMovieFromDislikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'dislikedMovies')

export {
  addMovieToDislikedMovies,
  addMovieToLikedMovies,
  addMovieToWatchlist,
  fetchMovieCredits,
  getDetail,
  removeMovieFromDislikedMovies,
  removeMovieFromLikedMovies,
  removeMovieFromList,
  removeMovieFromWatchlist
}
