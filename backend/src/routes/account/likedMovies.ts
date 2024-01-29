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

import { findEntity } from '@models/getObjects'
import { addMovieToLikedMovies, removeMovieFromLikedMovies } from '@models/movie'

import { Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /account/:accountId/likedMovies:
 *   post:
 *     summary: Add a movie to the user's liked movies.
 *     description: Add the movie passed as body in the connected user's liked movies.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - name: accountId
 *         in: path
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *       - name: movieId
 *         in: body
 *         required: true
 *         schema:
 *           type: object
 *           properties:
 *             movieId:
 *               type: integer
 *               format: int32
 *               description: The movie id that needs to be added to the user's liked movies.
 *     responses:
 *       '201':
 *         description: Movie successfully added to the user's liked movies.
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
 *   delete:
 *     summary: Removie a movie from the user's liked movies.
 *     description: Removie the movie passed in the url in the connected user's liked movies.
 *     consumes:
 *       - application/json
 *     parameters:
 *      - name: accountId
 *        in: path
 *        required: true
 *        schema:
 *          type: string
 *          format: uuid
 *      - name: movieId
 *        in: path
 *        required: true
 *        schema:
 *          type: integer
 *          format: int32
 *        description: "The movie id that needs to be removed from the user's liked movies."
 *     responses:
 *       '200':
 *         description: Movie successfully removed from the user's liked movies.
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
 *       '404':
 *         description: Not Found - the requested movie was not found in list.
 *       '500':
 *         description: Internal server error.
 *   get:
 *     summary: Get the account's watchlist.
 *     description: Retrieve a JSON which contains the list of liked movies.
 *     parameters:
 *      - name: accountId
 *        in: path
 *        required: true
 *        schema:
 *          type: string
 *          format: uuid
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

const rulesPost = [
  param('accountId').isUUID(),
  body('movieId').isNumeric()
]

router.post('/account/:accountId/likedMovies', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  addMovieToLikedMovies(req.params.accountId, req.body.movieId).then((updatedLikedMoviesList: number[]) => {
    logger.info(`Successfully added ${req.body.movieId} to ${req.session.account?.email}'s liked movies.`)
    return res.status(StatusCodes.CREATED).json(updatedLikedMoviesList)
  }).catch(handleErrorOnRoute(res))
})

const rulesDelete = [
  param('accountId').isUUID(),
  param('movieId').isNumeric()
]

router.delete('/account/:accountId/likedMovies/:movieId', rulesDelete, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  removeMovieFromLikedMovies(req.params.accountId, parseInt(req.params.movieId)).then((updatedLikedMoviesList: number[]) => {
    logger.info(`Successfully removed ${req.body.movieId} of ${req.session.account?.email}'s liked movies.`)
    return res.status(StatusCodes.OK).json(updatedLikedMoviesList)
  }).catch(handleErrorOnRoute(res))
})

const rulesGet = [
  param('accountId').isUUID()
]

router.get('/account/:accountId/likedMovies', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then((account: Account | null) => {
    if (account === null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.INTERNAL_SERVER_ERROR)
    }
    return res.status(StatusCodes.OK).json(account?.likedMovies)
  }).catch(handleErrorOnRoute(res))
})

export default router
