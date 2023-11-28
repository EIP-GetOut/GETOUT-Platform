/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { addBookToReadingList } from '@models/book'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

const rulesPost = [
  body('bookId').isString()
]

/**
 * @swagger
 * /account/:accountId/readingList:
 *   post:
 *     summary: Add a book to the user's reading list.
 *     description: Add the book passed as body in the connected user's reading list.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - name: body
 *         in: body
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             bookId:
 *               type: string
 *               description: The book id that needs to be added to the reading list.
 *     responses:
 *       '201':
 *         description: Book successfully added to the reading list.
 *         content:
 *           application/json:
 *           schema:
 *             type: array
 *             items:
 *               type: string
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - user is not connected.
 *       '500':
 *         description: Internal server error.
 *   get:
 *     summary: Get the account's reading list.
 *     description: Retrieve a JSON which contains the details of a book.
 *     parameters:
 *       - name: id
 *         in: path
 *         type: string
 *         description: ID of the book
 *         required: true
 *     responses:
 *       '200':
 *         description: Reading list successfully returned.
 *         content:
 *           application/json:
 *           schema:
 *             type: array
 *             items:
 *               type: string
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - user is not connected.
 *       '500':
 *         description: Internal server error.
 */

router.post('/account/:accountId/readingList', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  addBookToReadingList(req.params.accountId, req.body.bookId).then((updatedReadingList: string[]) => {
    logger.info(`Successfully added ${req.body.bookId} to ${req.session.account?.email}'s reading list`)
    return res.status(StatusCodes.CREATED).json(updatedReadingList)
  }).catch(handleErrorOnRoute(res))
})

router.get('/account/:accountId/readingList', logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then((account) => {
    return res.status(StatusCodes.OK).json(account?.readingList)
  }).catch(handleErrorOnRoute(res))
})

export default router
