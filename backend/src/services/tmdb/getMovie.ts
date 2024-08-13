/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import {
  MovieDb,
  type CreditsResponse as TMDBCreditsResponse,
  type MovieResponse as TMDBMovieResponse
} from 'moviedb-promise'

import { ApiError, AppError } from '@services/utils/customErrors'

const moviedb = new MovieDb(process.env.MOVIE_DB_KEY)

interface Cast {
  name: string
  picture: string | null
}

export interface MovieResponse {
  id: number
  title: string
  synopsis: string
  posterPath: string
  backdropPath: string
  releaseDate: string // formatted YYYY-MM-DD
  averageRating: number
  cast: Cast[]
  director: Cast
  duration: number
}

async function fetchMovieCredits (movieId: number): Promise<Cast []> {
  return await moviedb.movieCredits({ id: movieId }).then((credits: any) => {
    return credits.cast?.slice(0, 5).map((person: any) => ({
      name: person.name,
      picture: ((person.profile_path ?? '').length > 0)
        ? `https://image.tmdb.org/t/p/w200${person.profile_path}`
        : null
    } satisfies Cast))
  }).catch((err: Error) => {
    throw new ApiError(`Error whiled obtaining movie ${movieId}'s credits (${err.name}: ${err.message}).`)
  })
}

async function getDirector (movieId: number): Promise<any> {
  return await moviedb.movieCredits({ id: movieId }).then((credits: TMDBCreditsResponse) => {
    const director = credits.crew?.find(member => member.job === 'Director')
    if (director?.name == null) {
      throw new ApiError(`Error whiled obtaining movie ${movieId}'s director: director not found.`)
    }
    return ({
      name: director.name,
      picture: ((director?.profile_path ?? '').length > 0)
        ? `https://image.tmdb.org/t/p/w200${director?.profile_path}`
        : null
    } satisfies Cast)
  }).catch((err: Error | AppError) => {
    if (err instanceof AppError) {
      throw err
    }
    throw new ApiError(`Error whiled obtaining movie ${movieId}'s director (${err.name}: ${err.message}).`)
  })
}

async function getMovieDetails (id: number): Promise<TMDBMovieResponse> {
  return await moviedb.movieInfo(id).then((value: TMDBMovieResponse) => {
    return value
  }).catch((err: Error) => {
    throw new ApiError(`Error whiled obtaining movie ${id}'s infos (${err.name}: ${err.message}).`)
  })
}

async function getMovie (id: number): Promise<MovieResponse> {
  return await getMovieDetails(id).then(async (movieObtained: TMDBMovieResponse) => {
    return await fetchMovieCredits(id).then(async (cast: Cast []) => {
      return await getDirector(id).then((director: Cast) => {
        return ({
          id,
          title: movieObtained.title,
          synopsis: movieObtained.overview,
          posterPath: movieObtained.poster_path,
          backdropPath: movieObtained.backdrop_path,
          releaseDate: movieObtained.release_date,
          averageRating: Number(movieObtained.vote_average) / 2,
          cast,
          director,
          duration: movieObtained.runtime
        }) satisfies Partial<MovieResponse>
      })
    })
  }).then((movieResponse: Partial<MovieResponse>) => {
    for (const [key, value] of Object.entries(movieResponse)) {
      if (value == null) {
        throw new ApiError(`Value of property ${key} is missing in TMDB response.`)
      }
    }
    return movieResponse as MovieResponse
  }).catch((err: Error | AppError) => {
    if (err instanceof AppError) {
      throw err
    }
    throw new ApiError('Error while getting the movie details')
  })
}

export { getMovie }
