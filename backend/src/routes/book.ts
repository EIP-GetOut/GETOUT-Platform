/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Request, Response, Router } from "express";
import { getReasonPhrase, StatusCodes } from "http-status-codes";
import { json } from "stream/consumers";

import logger from "@middlewares/logging"

import { logApiRequest } from "@services/middlewares/logging";
import validate from "@services/middlewares/validator";

import { getBook } from "@models/book";

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
    //TODO create BooksResult interface
    return getBook(req.params).then((booksObtained: any | undefined) => {
        if (!booksObtained) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
        }
        logger.info(JSON.stringify(booksObtained, null, 2))
        const book = {
            title: booksObtained.volumeInfo.title,
            overview: booksObtained.volumeInfo.description,
            poster_path: booksObtained.volumeInfo?.imageLinks?.thumbnail ? booksObtained.volumeInfo.imageLinks.thumbnail : null,
            duration: Number(booksObtained.volumeInfo.pageCount) / 60 - (Number(booksObtained.volumeInfo.pageCount) / 60 % 1) + 'h' + Number(booksObtained.volumeInfo.pageCount) % 60 + 'min',
            authors: booksObtained.volumeInfo.authors,
            category: booksObtained.volumeInfo?.categories ? booksObtained.volumeInfo.categories : null,
        }
        return res.status(StatusCodes.OK).json({
            book
        })
    })
})

export default router