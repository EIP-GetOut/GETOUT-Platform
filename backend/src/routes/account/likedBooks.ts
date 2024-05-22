/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { body, param } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import logger, { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { AccountDoesNotExistError, AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { modifyAccount } from '@models/account'
import { addBookToLikedBooks, removeBookFromLikedBooks } from '@models/book'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /account/{accountId}/likedBooks:
 *   post:
 *     summary: Add a book to the user's liked books.
 *     description: Add the book passed as body in the connected user's liked books.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - name: accountId
 *         in: path
 *         required: true
 *         type: string
 *         format: uuid
 *       - name: bookId
 *         in: body
 *         required: true
 *         schema:
 *           type: string
 *           description: The book id that needs to be added to the liked books.
 *     responses:
 *       "201":
 *         description: Book successfully added to the liked books.
 *         schema:
 *           type: array
 *           items:
 *             type: string
 *       "400":
 *         description: Invalid request body or missing required fields.
 *       "401":
 *         description: Unauthorized - user is not connected.
 *       "500":
 *         description: Internal server error.
 *   delete:
 *     summary: Remove a book from the user's liked books.
 *     description: Remove the book passed in the url in the connected user's liked books.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - name: accountId
 *         in: path
 *         required: true
 *         type: string
 *         format: uuid
 *       - name: bookId
 *         in: body
 *         required: true
 *         schema:
 *           type: string
 *           description: The book id that needs to be removed from the liked books.
 *     responses:
 *       "200":
 *         description: Book successfully removed from the liked books.
 *         schema:
 *           type: array
 *           items:
 *             type: string
 *       "400":
 *         description: Invalid request body or missing required fields.
 *       "401":
 *         description: Unauthorized - user is not connected.
 *       "404":
 *         description: Not Found - the requested book was not found in list.
 *       "500":
 *         description: Internal server error.
 *   get:
 *     summary: Get the account's liked books.
 *     description: Retrieve a JSON which contains the user's liked books.
 *     parameters:
 *       - name: accountId
 *         in: path
 *         required: true
 *         type: string
 *         format: uuid
 *     responses:
 *       "200":
 *         description: Liked books successfully returned.
 *         schema:
 *           type: array
 *           items:
 *             type: string
 *       "400":
 *         description: Invalid request body or missing required fields.
 *       "401":
 *         description: Unauthorized - user is not connected.
 *       "500":
 *         description: Internal server error.
 */

const rulesPost = [
  param('accountId').isUUID(),
  body('bookId').isString()
]

router.post('/account/:accountId/likedBooks', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  addBookToLikedBooks(req.params.accountId, req.body.bookId).then(async (updatedLikedBooksList: string[]) => {
    return await modifyAccount(req.session.account!.id, { likedBooks: updatedLikedBooksList }).then(() => {
      logger.info(`Successfully added ${req.body.bookId} to ${req.session.account?.email}'s liked books`)
      return res.status(StatusCodes.CREATED).json(updatedLikedBooksList)
    })
  }).catch(handleErrorOnRoute(res))
})

const rulesDelete = [
  param('accountId').isUUID(),
  param('bookId').isString()
]

router.delete('/account/:accountId/likedBooks/:bookId', rulesDelete, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  removeBookFromLikedBooks(req.params.accountId, req.params.bookId).then(async (updatedLikedBooksList: string[]) => {
    return await modifyAccount(req.session.account!.id, { likedBooks: updatedLikedBooksList }).then(() => {
      logger.info(`Successfully removed ${req.body.bookId} of ${req.session.account?.email}'s liked books.`)
      return res.status(StatusCodes.OK).json(updatedLikedBooksList)
    })
  }).catch(handleErrorOnRoute(res))
})

const rulesGet = [
  param('accountId').isUUID()
]

router.get('/account/:accountId/likedBooks', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then((account: Account | null) => {
    if (account === null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.INTERNAL_SERVER_ERROR)
    }
    return res.status(StatusCodes.OK).json(account.likedBooks)
  }).catch(handleErrorOnRoute(res))
})

export default router
