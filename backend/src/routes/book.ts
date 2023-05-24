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

import { getBook } from "@models/book";

const router = Router()

router.get('/book/:id', validate, logApiRequest, (req: Request, res: Response) => {
    //TODO create BooksResult interface
    return getBook(req.params).then((booksObtained: any | undefined) => {
        if (!booksObtained) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
        }
        console.log(booksObtained)
        const book = {
            title: booksObtained.volumeInfo.title,
            authors: booksObtained.volumeInfo.authors,
            duration: Number(booksObtained.volumeInfo.pageCount) / 60 - (Number(booksObtained.volumeInfo.pageCount) / 60 % 1) + 'h' + Number(booksObtained.volumeInfo.pageCount) % 60 + 'min',
            synopsis: booksObtained.volumeInfo.description,
            category: booksObtained.volumeInfo?.categories ? booksObtained.volumeInfo.categories : null
        }
        return res.status(StatusCodes.OK).json({
            book
        })
    })
})

export default router