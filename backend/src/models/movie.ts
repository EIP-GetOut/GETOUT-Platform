/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Théo de Boysson <theo.de-boysson@epitech.eu>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'
import { MovieDb } from 'moviedb-promise'

import { AccountDoesNotExistError, type AppError, DbError, MovieNotInListError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

const moviedb = new MovieDb(process.env.MOVIE_DB_KEY)

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

const addMovieToLikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> => {
  return await addMovieToList(accountId, movieId, 'likedMovies').then(async (likedMovies: number []) => {
    return await removeMovieFromDislikedMovies(accountId, movieId).then((dislikedMovies: number[]) => {
      return likedMovies
    }).catch((err: AppError) => {
      if (err instanceof MovieNotInListError) {
        return likedMovies
      } else {
        throw err
      }
    })
  })
}

const addMovieToDislikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> => {
  return await addMovieToList(accountId, movieId, 'dislikedMovies').then(async (dislikedMovies: number []) => {
    return await removeMovieFromLikedMovies(accountId, movieId).then((likedMovies: number[]) => {
      return dislikedMovies
    }).catch((err: AppError) => {
      if (err instanceof MovieNotInListError) {
        return dislikedMovies
      } else {
        throw err
      }
    })
  })
}

const addMovieToSeenMovies = async (accountId: UUID, movieId: number): Promise<number[]> => {
  return await addMovieToList(accountId, movieId, 'seenMovies').then(async (seenMovies: number []) => {
    return await removeMovieFromWatchlist(accountId, movieId).then((watchlist: number[]) => {
      return seenMovies
    }).catch((err: AppError) => {
      if (err instanceof MovieNotInListError) {
        return seenMovies
      } else {
        throw err
      }
    })
  })
}

const removeMovieFromWatchlist = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'watchlist')

const removeMovieFromLikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'likedMovies')

const removeMovieFromDislikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'dislikedMovies')

const removeMovieFromSeenMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'seenMovies')

async function getRecommendation (movieId: number): Promise<any> {
  return await moviedb.movieRecommendations({ id: movieId })
}

export {
  addMovieToDislikedMovies,
  addMovieToLikedMovies,
  addMovieToSeenMovies,
  addMovieToWatchlist,
  getRecommendation,
  removeMovieFromDislikedMovies,
  removeMovieFromLikedMovies,
  removeMovieFromList,
  removeMovieFromSeenMovies,
  removeMovieFromWatchlist
}
