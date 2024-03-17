/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Théo de Boysson <theo.de-boysson@epitech.eu>
*/

import { type UUID } from 'crypto'
import { type Session, type SessionData } from 'express-session'
import { StatusCodes } from 'http-status-codes'
import { MovieDb, type MovieResponse } from 'moviedb-promise'

import { AccountDoesNotExistError, ApiError, type AppError, DbError, MovieNotInListError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

const moviedb = new MovieDb(process.env.MOVIE_DB_KEY)

async function fetchMovieCredits (movieId: number): Promise<any> {
  return await moviedb.movieCredits({ id: movieId }).then((credits: any) => {
    const cast = credits.cast?.slice(0, 5).map((person: any) => ({
      name: person.name,
      picture: ((person.profile_path ?? '').length > 0)
        ? `https://image.tmdb.org/t/p/w200${person.profile_path}`
        : null
    }))
    return cast
  }).catch((err: Error) => {
    throw new ApiError(`Error whiled obtaining movie ${movieId}'s credits (${err.name}: ${err.message}).`)
  })
}

async function getMovieDetail (id: number): Promise<MovieResponse> {
  return await moviedb.movieInfo(id).then((value: MovieResponse) => {
    return value
  }).catch((err: Error) => {
    throw new ApiError(`Error whiled obtaining movie ${id}'s infos (${err.name}: ${err.message}).`)
  })
}

async function getMovie (id: number): Promise<any> {
  return await getMovieDetail(id).then(async (movieObtained: MovieResponse) => {
    return await fetchMovieCredits(id).then((cast: any) => {
      return ({
        id,
        title: movieObtained.title,
        overview: movieObtained.overview,
        poster_path: movieObtained.poster_path,
        backdrop_path: movieObtained.backdrop_path,
        release_date: movieObtained.release_date,
        vote_average: Number(movieObtained.vote_average) / 2,
        cast,
        duration: movieObtained.runtime
      })
    })
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

const addMovieToLikedMovies = async (accountId: UUID, movieId: number, session: Session & Partial<SessionData>): Promise<number[]> => {
  return await addMovieToList(accountId, movieId, 'likedMovies').then(async (likedMovies: number []) => {
    return await removeMovieFromDislikedMovies(accountId, movieId).then((dislikedMovies: number[]) => {
      session.account!.dislikedMovies = dislikedMovies
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

const addMovieToDislikedMovies = async (accountId: UUID, movieId: number, session: Session & Partial<SessionData>): Promise<number[]> => {
  return await addMovieToList(accountId, movieId, 'dislikedMovies').then(async (dislikedMovies: number []) => {
    return await removeMovieFromLikedMovies(accountId, movieId).then((likedMovies: number[]) => {
      session.account!.likedMovies = likedMovies
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
const addMovieToSeenMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await addMovieToList(accountId, movieId, 'seenMovies')

const removeMovieFromWatchlist = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'watchlist')

const removeMovieFromLikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'likedMovies')

const removeMovieFromDislikedMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'dislikedMovies')

const removeMovieFromSeenMovies = async (accountId: UUID, movieId: number): Promise<number[]> =>
  await removeMovieFromList(accountId, movieId, 'seenMovies')

export {
  addMovieToDislikedMovies,
  addMovieToLikedMovies,
  addMovieToSeenMovies,
  addMovieToWatchlist,
  getMovie,
  removeMovieFromDislikedMovies,
  removeMovieFromLikedMovies,
  removeMovieFromList,
  removeMovieFromSeenMovies,
  removeMovieFromWatchlist
}
