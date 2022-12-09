/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Request, Response, Router } from "express";
import { query } from "express-validator";
import { getReasonPhrase, StatusCodes } from "http-status-codes";

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

router.get('/generate-books', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
    //TODO create BooksResult interface
    return getBooks(req.query).then((booksObtained: any | undefined) => {
        console.log(booksObtained);
        if (!booksObtained) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
        }
        booksObtained.items.length = 5
        ;
        return res.status(StatusCodes.OK).json({
            books: booksObtained.items
        })
    })
})

export default router