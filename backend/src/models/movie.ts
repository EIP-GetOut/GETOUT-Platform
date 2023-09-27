/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { MovieDb, type MovieResponse } from 'moviedb-promise'

import logger from '@middlewares/logging'

import { MovieDbError } from '@services/utils/customErrors'

const moviedb = new MovieDb('1eec31e851e9ad1b8f3de3ccf39953b7')

async function getDetail (params: any): Promise<MovieResponse | undefined> {
  return await moviedb.movieInfo(params.id).then((value: MovieResponse) => {
    logger.info(JSON.stringify(value, null, 2))
    return value
  }).catch((err: Error) => {
    throw new MovieDbError(err.message)
  })
}

export { getDetail }
