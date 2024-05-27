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
import { findEntity } from '@models/getObjects'
import { addMovieToWatchlist, removeMovieFromWatchlist } from '@models/movie'

import { Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /account/{accountId}/watchlist:
 *   post:
 *     summary: Add a movie to the user's watchlist.
 *     description: Add the movie passed as body in the connected user's watchlist.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - name: accountId
 *         in: path
 *         required: true
 *         type: string
 *         format: uuid
 *         description: The ID of the user's account.
 *       - name: movieId
 *         in: body
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             movieId:
 *               type: integer
 *               format: int32
 *               description: The movie id that needs to be added to the user's watchlist.
 *     responses:
 *       '201':
 *         description: Movie successfully added to the watchlist.
 *         schema:
 *           type: array
 *           items:
 *             type: number
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - user is not connected.
 *       '500':
 *         description: Internal server error.
 *   delete:
 *     summary: Remove a movie from the user's watchlist.
 *     description: Remove the movie passed in the url in the connected user's watchlist.
 *     consumes:
 *       - application/json
 *     parameters:
 *      - name: accountId
 *        in: path
 *        required: true
 *        type: string
 *        format: uuid
 *      - name: movieId
 *        in: body
 *        required: true
 *        schema:
 *          type: integer
 *          format: int32
 *        description: The movie id that needs to be removed from the user's watchlist.
 *     responses:
 *       '200':
 *         description: Movie successfully removed from the watchlist.
 *         schema:
 *           type: array
 *           items:
 *             type: number
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - user is not connected.
 *       '404':
 *         description: Not Found - the requested movie was not found in list.
 *       '500':
 *         description: Internal server error.
 *   get:
 *     summary: Get the account's watchlist.
 *     description: Retrieve a JSON which contains the user's watchlist.
 *     parameters:
 *      - name: accountId
 *        in: path
 *        required: true
 *        type: string
 *        format: uuid
 *     responses:
 *       '200':
 *         description: Watchlist successfully returned.
 *         schema:
 *           type: array
 *           items:
 *             type: number
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - user is not connected.
 *       '500':
 *         description: Internal server error.
 */

const rulesPost = [
  param('accountId').isUUID(),
  body('movieId').isNumeric()
]

router.post('/account/:accountId/watchlist', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  addMovieToWatchlist(req.params.accountId, parseInt(req.body.movieId)).then(async (updatedWatchlist: number[]) => {
    return await modifyAccount(req.session.account!.id, { watchlist: updatedWatchlist }).then(() => {
      logger.info(`Successfully added ${req.body.movieId} to ${req.session.account?.email}'s watchlist`)
      return res.status(StatusCodes.CREATED).json(updatedWatchlist)
    })
  }).catch(handleErrorOnRoute(res))
})

const rulesDelete = [
  param('accountId').isUUID(),
  param('movieId').isNumeric()
]

router.delete('/account/:accountId/watchlist/:movieId', rulesDelete, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  removeMovieFromWatchlist(req.params.accountId, parseInt(req.params.movieId)).then(async (updatedWatchlist: number[]) => {
    return await modifyAccount(req.session.account!.id, { watchlist: updatedWatchlist }).then(() => {
      logger.info(`Successfully removed ${req.params.movieId} of ${req.session.account?.email}'s watchlist.`)
      return res.status(StatusCodes.OK).json(updatedWatchlist)
    })
  }).catch(handleErrorOnRoute(res))
})

const rulesGet = [
  param('accountId').isUUID()
]

router.get('/account/:accountId/watchlist', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then((account: Account | null) => {
    if (account === null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.INTERNAL_SERVER_ERROR)
    }
    return res.status(StatusCodes.OK).json(account.watchlist)
  }).catch(handleErrorOnRoute(res))
})

export default router
