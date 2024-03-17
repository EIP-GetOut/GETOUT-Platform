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
import { addMovieToSeenMovies, removeMovieFromSeenMovies } from '@models/movie'

import { Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /account/{accountId}/seenMovies:
 *   post:
 *     summary: Add a movie to the user's seen movies.
 *     description: Add the movie passed as body in the connected user's seen movies.
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
 *               description: The movie id that needs to be added to the user's seen movies.
 *     responses:
 *       '201':
 *         description: Movie successfully added to the seen movies.
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
 *     summary: Remove a movie from the user's seen movies.
 *     description: Remove the movie passed in the url in the connected user's seen movies.
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
 *        description: "The movie id that needs to be removed from the user's seen movies."
 *     responses:
 *       '200':
 *         description: Movie successfully removed from the seen movies.
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
 *     summary: Get the account's seen movies.
 *     description: Retrieve a JSON which contains the user's seen movies.
 *     parameters:
 *      - name: accountId
 *        in: path
 *        required: true
 *        type: string
 *        format: uuid
 *     responses:
 *       '200':
 *         description: Seen movies list successfully returned.
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

router.post('/account/:accountId/seenMovies', rulesPost, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  addMovieToSeenMovies(req.params.accountId, parseInt(req.body.movieId)).then((updatedSeenMovies: number[]) => {
    logger.info(`Successfully added ${req.body.movieId} to ${req.session.account?.email}'s seen movies.`)
    req.session.account!.seenMovies = updatedSeenMovies
    return res.status(StatusCodes.CREATED).json(updatedSeenMovies)
  }).catch(handleErrorOnRoute(res))
})

const rulesDelete = [
  param('accountId').isUUID(),
  param('movieId').isNumeric()
]

router.delete('/account/:accountId/seenMovies/:movieId', rulesDelete, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  removeMovieFromSeenMovies(req.params.accountId, parseInt(req.params.movieId)).then((updatedSeenMovies: number[]) => {
    logger.info(`Successfully removed ${req.params.movieId} of ${req.session.account?.email}'s seen movies.`)
    req.session.account!.seenMovies = updatedSeenMovies
    return res.status(StatusCodes.OK).json(updatedSeenMovies)
  }).catch(handleErrorOnRoute(res))
})

const rulesGet = [
  param('accountId').isUUID()
]

router.get('/account/:accountId/seenMovies', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError())
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then((account: Account | null) => {
    if (account === null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.INTERNAL_SERVER_ERROR)
    }
    return res.status(StatusCodes.OK).json(account.seenMovies)
  }).catch(handleErrorOnRoute(res))
})

export default router
