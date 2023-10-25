/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger from '@middlewares/logging'

import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AppError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getBook } from '@models/book'

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
 *             book:
 *               type: object
 *               properties:
 *                 title:
 *                   type: string
 *                 overview:
 *                   type: string
 *                 poster_path:
 *                   type: string
 *                 duration:
 *                   type: string
 *                 authors:
 *                   type: array
 *                   items:
 *                     type: string
 *                 category:
 *                   type: string
 *       '500':
 *         description: Internal server error.
 */
router.get('/book/:id', validate, logApiRequest, (req: Request, res: Response) => {
  getBook(req.body).then((bookObtained: any | undefined) => {
    if (bookObtained == null) {
      throw new AppError()
    }
    logger.info(JSON.stringify(bookObtained, null, 2))
    const book = {
      title: bookObtained.volumeInfo.title,
      overview: bookObtained.volumeInfo.description,
      poster_path: bookObtained.volumeInfo?.imageLinks?.thumbnail != null ? bookObtained.volumeInfo.imageLinks.thumbnail : null,
      duration: Number(bookObtained.volumeInfo.pageCount) / 60 - (Number(bookObtained.volumeInfo.pageCount) / 60 % 1) + 'h' + Number(bookObtained.volumeInfo.pageCount) % 60 + 'min',
      authors: bookObtained.volumeInfo.authors,
      category: bookObtained.volumeInfo?.categories != null ? bookObtained.volumeInfo.categories : null
    }
    return res.status(StatusCodes.OK).json({ book })
  }).catch(handleErrorOnRoute(res))
})

export default router
