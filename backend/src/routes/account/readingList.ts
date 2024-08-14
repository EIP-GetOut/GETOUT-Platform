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
import { preloadNextRecommendations } from '@services/recommendationsCaching/books'
import { AccountDoesNotExistError, AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'
import { mapAccountToSession } from '@services/utils/mapAccountToSession'

import { modifyAccount } from '@models/account'
import { addBookToReadingList, removeBookFromReadingList } from '@models/book'
import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /account/{accountId}/readingList:
 *   post:
 *     summary: Add a book to the user's reading list.
 *     description: Add the book passed as body in the connected user's reading list.
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
 *           description: The book id that needs to be added to the reading list.
 *     responses:
 *       "201":
 *         description: Book successfully added to the reading list.
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
 *     summary: Remove a book from the user's reading list.
 *     description: Remove the book passed in the url in the connected user's reading list.
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
 *           description: The book id that needs to be removed from the reading list.
 *     responses:
 *       "200":
 *         description: Book successfully removed from the reading list.
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
 *     summary: Get the account's reading list.
 *     description: Retrieve a JSON which contains the user's reading list.
 *     parameters:
 *       - name: accountId
 *         in: path
 *         required: true
 *         type: string
 *         format: uuid
 *     responses:
 *       "200":
 *         description: Reading list successfully returned.
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

router.post('/account/:accountId/readingList', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  const accountId = req.params.accountId
  addBookToReadingList(req.params.accountId, req.body.bookId).then(async (updatedReadingList: string[]) => {
    await modifyAccount(req.session.account!.id, { readingList: updatedReadingList }).then(async () => {
      /* This will be deleted when not necessary for the frontend anymore and not in the session */
      return await mapAccountToSession(req, true)
    }).then(() => {
      logger.info(`Successfully added ${req.body.bookId} to ${req.session.account?.email}'s reading list`)
      return res.status(StatusCodes.CREATED).json(updatedReadingList)
    }).then(async () => {
      if (process.env.NODE_ENV !== 'test') {
        await preloadNextRecommendations(accountId).catch((err: Error) => {
          logger.error(`${err.name}: ${err.message}`)
        })
      }
    })
  }).catch(handleErrorOnRoute(res))
})

const rulesDelete = [
  param('accountId').isUUID(),
  param('bookId').isString()
]

router.delete('/account/:accountId/readingList/:bookId', rulesDelete, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  const accountId = req.params.accountId
  removeBookFromReadingList(req.params.accountId, req.params.bookId).then(async (updatedReadingList: string[]) => {
    await modifyAccount(req.session.account!.id, { readingList: updatedReadingList }).then(async () => {
      /* This will be deleted when not necessary for the frontend anymore and not in the session */
      return await mapAccountToSession(req, true)
    }).then(() => {
      logger.info(`Successfully removed ${req.body.bookId} of ${req.session.account?.email}'s reading list.`)
      return res.status(StatusCodes.OK).json(updatedReadingList)
    }).then(async () => {
      if (process.env.NODE_ENV !== 'test') {
        await preloadNextRecommendations(accountId).catch((err: Error) => {
          logger.error(`${err.name}: ${err.message}`)
        })
      }
    })
  }).catch(handleErrorOnRoute(res))
})

const rulesGet = [
  param('accountId').isUUID()
]

router.get('/account/:accountId/readingList', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then((account: Account | null) => {
    if (account === null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.INTERNAL_SERVER_ERROR)
    }
    return res.status(StatusCodes.OK).json(account.readingList)
  }).catch(handleErrorOnRoute(res))
})

export default router
