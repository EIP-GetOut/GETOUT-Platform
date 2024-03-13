/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { MovieDb, type DiscoverMovieRequest, type DiscoverMovieResponse, type MovieResult } from 'moviedb-promise'

import logger from '@middlewares/logging'

import { ApiError } from '@services/utils/customErrors'

import { type MoviesDTO } from '@routes/generateMovies.dto'

const moviedb = new MovieDb(process.env.MOVIE_DB_KEY)

async function getMovies (params: MoviesDTO): Promise<MovieResult[] | undefined> {
  const discorverMovieRequest: DiscoverMovieRequest = {
    include_adult: params.include_adult === 'true',
    include_video: params.include_video === 'true',
    with_genres: params.with_genres,
    page: (params.page !== undefined) ? parseInt(params.page) : 1
  }

  return await moviedb.discoverMovie(discorverMovieRequest).then((value: DiscoverMovieResponse) => {
    logger.info(JSON.stringify(value, null, 2))
    return value.results
  }).catch((err: Error) => {
    throw new ApiError(`Error whiled discovering movies (${err.name}: ${err.message}).`)
  })
}

export { getMovies }
