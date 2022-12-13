/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Firstname Lastname <firstname.lastname@domain.com>
*/

import { Request, Response, Router } from "express";
import { query } from "express-validator";
import { getReasonPhrase, StatusCodes } from "http-status-codes";
import { MovieResponse }  from 'moviedb-promise'

import logger, { logApiRequest } from "@services/middlewares/logging";
import validate from "@services/middlewares/validator";

import { getDetail } from "@models/movie";

const router = Router();

const rulesGet = [
    query('id').isNumeric()
]

router.get('/movie/:id', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
    logger.info(req.query)
    return getDetail(req.query).then((movieObtained: MovieResponse | undefined) => {
        if (!movieObtained) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
        }
        const movie = {
            title: movieObtained.title,
            overview: movieObtained.overview,
            poster_path: movieObtained.poster_path,
            backdrop_path: movieObtained.backdrop_path,
            release_date: movieObtained.release_date,
            vote_average: Number(movieObtained.vote_average) / 2,
            duration: Number(movieObtained.runtime) / 60 - (Number(movieObtained.runtime) / 60 % 1) + 'h' + Number(movieObtained.runtime) % 60 + 'min',
        }
        return res.status(StatusCodes.OK).json({
            movie
        })
    })
})

export default router