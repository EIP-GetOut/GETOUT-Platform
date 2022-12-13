/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/


import { MovieDb, MovieResponse } from 'moviedb-promise'

const moviedb = new MovieDb('1eec31e851e9ad1b8f3de3ccf39953b7')

function getDetail(params: any): Promise<MovieResponse | undefined> {
    return moviedb.movieInfo(params.id).then((value: MovieResponse) => {
        console.log('RES OBTAINED/', value)
        return value
    })
}

export { getDetail }