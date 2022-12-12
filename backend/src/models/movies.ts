/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { MovieDb, DiscoverMovieRequest, DiscoverMovieResponse, MovieResult } from 'moviedb-promise'

const moviedb = new MovieDb('1eec31e851e9ad1b8f3de3ccf39953b7')

function getMovies(params: any): Promise<MovieResult[] | undefined> {
    const discorverMovieRequest: DiscoverMovieRequest = {
        include_adult: params.include_adult === 'true' ? true : false,
        include_video: params.includevideo === 'true' ? true : false,
        page: params.page ? parseInt(params.page) : 1,
    };

    return moviedb.discoverMovie(discorverMovieRequest).then((value: DiscoverMovieResponse) => {
        console.log('RES OBTAINED/', value)
        return value.results
    })
}

export { getMovies }