/*
** Copyright Area - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Théo de Boysson <theo.de-boysson@epitech.eu>
*/

import logger, { logApiRequest } from "@services/middlewares/logging";
import validate from "@services/middlewares/validator";
import { query } from "express-validator";
import { Request, Response, Router } from "express";

import { MovieResponse }  from 'moviedb-promise'
import { getReasonPhrase, StatusCodes } from "http-status-codes";
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
        return res.status(StatusCodes.OK).json({
            movieObtained
        })
    })
})

export default router