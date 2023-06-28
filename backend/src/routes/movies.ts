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

/**
 * @swagger
 * /generate-movies:
 *   get:
 *     summary: Generate 5 films
 *     description: Generate 5 films using the provided query parameters.
 *     parameters:
 *       - name: region
 *         in: query
 *         type: string
 *         description: Filter films by region.
 *       - name: sort_by
 *         in: query
 *         type: string
 *         enum:
 *           - popularity.asc
 *           - popularity.desc
 *           - release_date.asc
 *           - release_date.desc
 *           - revenue.asc
 *           - revenue.desc
 *           - primary_release_date.asc
 *           - primary_release_date.desc
 *           - original_title.asc
 *           - original_title.desc
 *           - vote_average.asc
 *           - vote_average.desc
 *           - vote_count.asc
 *           - vote_count.desc
 *         description: Sort films by the specified criteria.
 *       - name: certification_country
 *         in: query
 *         type: string
 *         description: Filter films by certification country.
 *       - name: certification
 *         in: query
 *         type: string
 *         description: Filter films by certification.
 *       - name: certification.lte
 *         in: query
 *         type: string
 *         description: Filter films by certification less than or equal to the specified value.
 *       - name: certification.gte
 *         in: query
 *         type: string
 *         description: Filter films by certification greater than or equal to the specified value.
 *       - name: include_adult
 *         in: query
 *         type: boolean
 *         description: Include adult films in the results.
 *       - name: include_video
 *         in: query
 *         type: boolean
 *         description: Include films with video content in the results.
 *       - name: page
 *         in: query
 *         type: number
 *         description: Page number of the results.
 *       - name: primary_release_year
 *         in: query
 *         type: number
 *         description: Filter films by the primary release year.
 *       - name: primary_release_date.gte
 *         in: query
 *         type: string
 *         description: Filter films with primary release date greater than or equal to the specified value.
 *       - name: primary_release_date.lte
 *         in: query
 *         type: string
 *         description: Filter films with primary release date less than or equal to the specified value.
 *       - name: release_date.gte
 *         in: query
 *         type: string
 *         description: Filter films with release date greater than or equal to the specified value.
 *       - name: release_date.lte
 *         in: query
 *         type: string
 *         description: Filter films with release date less than or equal to the specified value.
 *       - name: with_release_type
 *         in: query
 *         type: number
 *         description: Filter films with the specified release type.
 *       - name: year
 *         in: query
 *         type: number
 *         description: Filter films by the year of release.
 *       - name: vote_count.gte
 *         in: query
 *         type: number
 *         description: Filter films with vote count greater than or equal to the specified value.
 *       - name: vote_count.lte
 *         in: query
 *         type: number
 *         description: Filter films with vote count less than or equal to the specified value.
 *       - name: vote_average.gte
 *         in: query
 *         type: number
 *         description: Filter films with vote average greater than or equal to the specified value.
 *       - name: vote_average.lte
 *         in: query
 *         type: number
 *         description: Filter films with vote average less than or equal to the specified value.
 *       - name: with_cast
 *         in: query
 *         type: string
 *         description: Filter films with the specified cast member.
 *       - name: with_crew
 *         in: query
 *         type: string
 *         description: Filter films with the specified crew member.
 *       - name: with_people
 *         in: query
 *         type: string
 *         description: Filter films with the specified people.
 *       - name: with_companies
 *         in: query
 *         type: string
 *         description: Filter films with the specified production companies.
 *       - name: with_genres
 *         in: query
 *         type: string
 *         description: Filter films with the specified genres.
 *       - name: without_genres
 *         in: query
 *         type: string
 *         description: Filter films without the specified genres.
 *       - name: with_keywords
 *         in: query
 *         type: string
 *         description: Filter films with the specified keywords.
 *       - name: without_keywords
 *         in: query
 *         type: string
 *         description: Filter films without the specified keywords.
 *       - name: with_runtime.gte
 *         in: query
 *         type: number
 *         description: Filter films with runtime greater than or equal to the specified value.
 *       - name: with_runtime.lte
 *         in: query
 *         type: number
 *         description: Filter films with runtime less than or equal to the specified value.
 *       - name: with_original_language
 *         in: query
 *         type: string
 *         description: Filter films with the specified original language.
 *       - name: with_watch_providers
 *         in: query
 *         type: string
 *         description: Filter films with the specified watch providers.
 *       - name: watch_region
 *         in: query
 *         type: string
 *         description: Filter films by watch region.
 *       - name: with_watch_monetization_types
 *         in: query
 *         type: string
 *         description: Filter films with the specified watch monetization types.
 *
 *     responses:
 *       '200':
 *         description: Successfully generated 5 films.
 *         schema:
 *           type: object
 *           properties:
 *             films:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   title:
 *                     type: string
 *                   poster:
 *                     type: string
 *                   id:
 *                     type: string
 *                   overview:
 *                     type: string
 *       '500':
 *         description: Internal server error.
 */
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