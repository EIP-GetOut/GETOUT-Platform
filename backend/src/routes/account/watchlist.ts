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

import { findEntity } from '@models/getObjects'
import { addMovieToWatchlist } from '@models/movie'

import { Account } from '@entities/Account'

const router = Router()

const rulesPost = [
  body('movieId').isNumeric()
]

/**
 * @swagger
 * /account/:accountId/watchlist:
 *   post:
 *     summary: Add a movie to the user's watchlist.
 *     description: Add the movie passed as body in the connected user's watchlist.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - name: body
 *         in: body
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             movieId:
 *               type: integer
 *               format: int32
 *               description: The movie id that needs to be added to the watchlist.
 *     responses:
 *       '201':
 *         description: Movie successfully added to the watchlist.
 *         content:
 *           application/json:
 *           schema:
 *             type: array
 *             items:
 *               type: number
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - user is not connected.
 *       '500':
 *         description: Internal server error.
 *   get:
 *     summary: Get the account's watchlist.
 *     description: Retrieve a JSON which contains the details of a book.
 *     parameters:
 *       - name: id
 *         in: path
 *         type: string
 *         description: ID of the book.
 *         required: true
 *     responses:
 *       '200':
 *         description: Watchlist successfully returned.
 *         content:
 *           application/json:
 *           schema:
 *             type: array
 *             items:
 *               type: number
 *       '400':
 *         description: Invalid request body or missing required fields.
 *       '401':
 *         description: Unauthorized - user is not connected.
 *       '500':
 *         description: Internal server error.
 */

router.post('/account/:accountId/watchlist', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  addMovieToWatchlist(req.params.accountId, req.body.movieId).then((updatedWatchlist: number[]) => {
    logger.info(`Successfully added ${req.body.movieId} to ${req.session.account?.email}'s watchlist`)
    return res.status(StatusCodes.CREATED).json(updatedWatchlist)
  }).catch(handleErrorOnRoute(res))
})

router.get('/account/:accountId/watchlist', logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then((account) => {
    return res.status(StatusCodes.OK).json(account?.watchlist)
  }).catch(handleErrorOnRoute(res))
})

export default router
