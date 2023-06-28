/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Request, Response, Router } from "express";
import { query } from "express-validator";
import { getReasonPhrase, StatusCodes } from "http-status-codes";

import logger from "@middlewares/logging"

import { logApiRequest } from "@services/middlewares/logging";
import validate from "@services/middlewares/validator";

import { getBooks } from "@models/books";

const router = Router()

const rulesGet = [
    query('intitle').isString().optional(),
    query('inauthor').isString().optional(),
    query('inpublisher').isString().optional(),
    query('subject').isString().optional(),
    query('printType').isString().optional(),
    query('orderBy').isString().optional(),
    query('pagination').isString().optional()
]

/**
 * @swagger
 * /generate-books:
 *   get:
 *     summary: Generate 5 books
 *     description: Generate 5 books using the provided query parameters.
 *     parameters:
 *       - name: intitle
 *         in: query
 *         type: string
 *         description: Filter books by title.
 *         required: false
 *       - name: inauthor
 *         in: query
 *         type: string
 *         description: Filter books by author.
 *         required: false
 *       - name: inpublisher
 *         in: query
 *         type: string
 *         description: Filter books by publisher.
 *         required: false
 *       - name: subject
 *         in: query
 *         type: string
 *         description: Filter books by subject.
 *         required: false
 *       - name: printType
 *         in: query
 *         type: string
 *         description: Filter books by type (book or magazine).
 *         required: false
 *       - name: orderBy
 *         in: query
 *         type: string
 *         description: Sort by relevance or newest.
 *         required: false
 *       - name: pagination
 *         in: query
 *         type: string
 *         description: Paginate the results.
 *         required: false
 *     responses:
 *       '200':
 *         description: Successfully generated 5 books.
 *         schema:
 *           type: object
 *           properties:
 *             books:
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
router.get('/generate-books', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
    //TODO create BooksResult interface
    return getBooks(req.query).then((booksObtained: any | undefined) => {
        logger.info(JSON.stringify(booksObtained, null, 2))
        if (!booksObtained) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
        }
        booksObtained.items.length = 5;
        const books: Array<any> = []
        booksObtained.items.forEach((book: any) => {
            books.push({
                title: book.volumeInfo.title,
                poster: book.volumeInfo?.imageLinks?.thumbnail ? book.volumeInfo.imageLinks.thumbnail : null,
                id: book.id,
                overview: book.volumeInfo?.description ? book.volumeInfo.description : 'No informations.'
            })
        });
        return res.status(StatusCodes.OK).json({
            books: books
        })
    })
})

export default router