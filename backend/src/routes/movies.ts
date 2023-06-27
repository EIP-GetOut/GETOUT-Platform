/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Request, Response, Router } from "express";
import { query } from "express-validator";
import { StatusCodes, getReasonPhrase } from "http-status-codes";
import { MovieResult } from "moviedb-promise";

import { logApiRequest } from "@services/middlewares/logging";
import validate from "@services/middlewares/validator";

import { getMovies } from "@models/movies";

const router = Router();

const rulesGet = [
    query('region').isString().optional(),
    query('sort_by').isIn([
        'popularity.asc',
        'popularity.desc',
        'release_date.asc',
        'release_date.desc',
        'revenue.asc',
        'revenue.desc',
        'primary_release_date.asc',
        'primary_release_date.desc',
        'original_title.asc',
        'original_title.desc',
        'vote_average.asc',
        'vote_average.desc',
        'vote_count.asc',
        'vote_count.desc'
    ]).optional(),
    query('certification_country').isString().optional(),
    query('certification').isString().optional(),
    query('certification.lte').isString().optional(),
    query('certification.gte').isString().optional(),
    query('include_adult').isBoolean().optional(),
    query('include_video').isBoolean().optional(),
    query('page').isNumeric().optional(),
    query('primary_release_year').isNumeric().optional(),
    query('primary_release_date.gte').isString().optional(),
    query('primary_release_date.lte').isString().optional(),
    query('release_date.gte').isString().optional(),
    query('release_date.lte').isString().optional(),
    query('with_release_type').isNumeric().optional(),
    query('year').isNumeric().optional(),
    query('vote_count.gte').isNumeric().optional(),
    query('vote_count.lte').isNumeric().optional(),
    query('vote_average.gte').isNumeric().optional(),
    query('vote_average.lte').isNumeric().optional(),
    query('with_cast').isString().optional(),
    query('with_crew').isString().optional(),
    query('with_people').isString().optional(),
    query('with_companies').isString().optional(),
    query('with_genres').isString().optional(),
    query('without_genres').isString().optional(),
    query('with_keywords').isString().optional(),
    query('without_keywords').isString().optional(),
    query('with_runtime.gte').isNumeric().optional(),
    query('with_runtime.lte').isNumeric().optional(),
    query('with_original_language').isString().optional(),
    query('with_watch_providers').isString().optional(),
    query('watch_region').isString().optional(),
    query('with_watch_monetization_types').isString().optional(),
]

router.get('/generate-movies', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
    console.log(req.query);
    return getMovies(req.query).then((moviesObtained: MovieResult[] | undefined) => {
        if (!moviesObtained) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
        }
        moviesObtained.length = 5;
        const movies: Array<any> = []
        moviesObtained.forEach(movie => {
            movies.push({
                title: movie.title,
                poster: movie.poster_path,
                id: movie.id,
                overview: movie.overview
            })
        });
        return res.status(StatusCodes.OK).json({
            movies
        })
    })
})

export default router