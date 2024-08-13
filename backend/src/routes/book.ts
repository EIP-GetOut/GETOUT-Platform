/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger from '@middlewares/logging'

import { getBook } from '@services/googlebooks/getBooks'
import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

const router = Router()

/**
 * @swagger
 * /book/{id}:
 *   get:
 *     summary: Get the details of a book
 *     description: Retrieve a JSON which contains the details of a book.
 *     parameters:
 *       - name: id
 *         in: path
 *         type: string
 *         description: ID of the book
 *         required: true
 *     responses:
 *       '200':
 *         description: A JSON with the title, overview, poster_path, duration, authors, and category.
 *         schema:
 *           type: object
 *           properties:
 *             title:
 *               type: string
 *             overview:
 *               type: string
 *             poster_path:
 *               type: string
 *             duration:
 *               type: string
 *             authors:
 *               type: array
 *               items:
 *                 type: string
 *             authorsPicture:
 *               type: array
 *               items:
 *                 type: string
 *             category:
 *                   type: string
 *       '500':
 *         description: Internal server error.
 */

router.get('/book/:id', validate, logApiRequest, (req: Request, res: Response) => {
  getBook(req.params.id, true).then(async (book: any) => {
    logger.info(`Successfully retreived book ${req.params.id}: ${JSON.stringify(book, null, 2)}`)
    return res.status(StatusCodes.OK).json({ ...book })
  }).catch(handleErrorOnRoute(res))
})

export default router
