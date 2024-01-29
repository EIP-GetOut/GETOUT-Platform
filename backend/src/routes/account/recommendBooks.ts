/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response, Router } from 'express'
import { query } from 'express-validator'
import { StatusCodes } from 'http-status-codes'
import { type Options, PythonShell } from 'python-shell'

import logger from '@middlewares/logging'

import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AppError, NotLoggedInError, PreferencesDoesNotExistError, RecommandationsDetailsError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getBook } from '@models/book'
import { type BooksResults, type BookResult } from '@models/book-types'
import { getBooks } from '@models/books'
import { type books } from '@models/books.interface'

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
 * /recommend-books:
 *   get:
 *     summary: Recommend 5 books
 *     description: Recommend 5 books using the provided query parameters.
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

router.get('/account/:accountId/recommend-books', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
    return
  }
  getBooks(req.query).then((booksObtained: BooksResults | undefined): void => {
    logger.info(JSON.stringify(booksObtained, null, 2))
    if (booksObtained == null) {
      throw new AppError()
    }
    booksObtained.items.length = 5
    const books: books[] = []
    booksObtained.items.forEach((book: BookResult) => {
      books.push({
        title: book?.volumeInfo?.title,
        poster: book.volumeInfo?.imageLinks?.thumbnail != null ? book.volumeInfo.imageLinks.thumbnail : null,
        id: book.id,
        overview: book.volumeInfo?.description != null ? book.volumeInfo.description : 'No informations.'
      })
    })
    res.status(StatusCodes.OK).json({ books })
  }).catch(handleErrorOnRoute(res))
})

router.get('/account/:accountId/recommend-books/V2', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session?.account?.id == null) {
    handleErrorOnRoute(res)(new NotLoggedInError())
  }
  if (req.session.account?.preferences == null) {
    handleErrorOnRoute(res)(new PreferencesDoesNotExistError())
  }

  const options: Options = {
    mode: 'json',
    pythonPath: '/usr/bin/python3',
    pythonOptions: [],
    scriptPath: 'src/services/recommandations/',
    args: [JSON.stringify(req.session.account)]
  }

  PythonShell.run('books.py', options).then(async ([output]: any) => {
    const recommandations = output.recommandations
    const promisesArray: Array<Promise<any>> = []

    recommandations.forEach((recommandation: any) => {
      promisesArray.push(getBook(recommandation.id))
    })

    await Promise.all(promisesArray).then((resolvedPromises) => {
      resolvedPromises.forEach((resolvedPromise: any, index) => {
        resolvedPromise.score = recommandations[index].score
      })
      logger.info(`Successfully retreived movie recommandations: ${JSON.stringify(recommandations, null, 2)}`)
      return res.status(StatusCodes.OK).json(resolvedPromises)
    }).catch(() => {
      throw new RecommandationsDetailsError()
    })
  }).catch(handleErrorOnRoute(res))
})

export default router
