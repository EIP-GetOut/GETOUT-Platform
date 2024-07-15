/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Théo de Boysson <theo.de-boysson@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getMovie } from '@models/movie'

const router = Router()

/**
 * @swagger
 * /movie/{id}:
 *   get:
 *     summary: Get the details of a film
 *     description: Retrieve a JSON which contains the details of a film.
 *     parameters:
 *       - name: id
 *         in: path
 *         type: string
 *         description: ID of the film
 *         required: true
 *     responses:
 *       '200':
 *         description: A JSON with the title, overview, poster_path, backdrop_path, release_date, vote_average, and duration of the film.
 *         schema:
 *           type: object
 *           properties:
 *             title:
 *               type: string
 *             overview:
 *               type: string
 *             poster_path:
 *               type: string
 *             backdrop_path:
 *               type: string
 *             release_date:
 *               type: string
 *               format: date
 *             cast:
 *               type: array
 *               items:
 *                 type: string
 *             vote_average:
 *               type: number
 *             duration:
 *                   type: string
 *       '500':
 *         description: Internal server error.
 */

router.get('/movie/:id', validate, logApiRequest, (req: Request, res: Response) => {
  getMovie(parseInt(req.params.id)).then((movie: any) => {
    logger.info(`Successfully retreived movie ${req.params.id}: ${JSON.stringify(movie, null, 2)}`)
    res.status(StatusCodes.OK).json({ ...movie })
  }).catch(handleErrorOnRoute(res))
})

export default router
