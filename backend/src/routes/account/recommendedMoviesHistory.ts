/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Request, type Response, Router } from 'express'
import { param } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { getMovie } from '@services/tmdb/getMovie'
import { AccountDoesNotExistError, AuthenticationError } from '@services/utils/customErrors'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { findEntity } from '@models/getObjects'

import { Account } from '@entities/Account'

const router = Router()

/**
 * @swagger
 * /account/{accountId}/recommendedMoviesHistory:
 *   get:
 *     summary: Get the account's history of recommended movies.
 *     description: Retrieve a JSON which contains the accounts's history of recommended movies.
 *     parameters:
 *       - name: accountId
 *         in: path
 *         required: true
 *         type: string
 *         format: uuid
 *     responses:
 *       "200":
 *         description: History of recommended movies list successfully returned.
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

const rulesGet = [
  param('accountId').isUUID()
]

router.get('/account/:accountId/recommendedMoviesHistory', rulesGet, validate, logApiRequest, (req: Request, res: Response) => {
  if (req.session.account?.id == null || req.session.account.id !== req.params.accountId) {
    handleErrorOnRoute(res)(new AuthenticationError('User must be connected.'))
    return
  }
  findEntity<Account>(Account, { id: req.params.accountId }).then(async (account: Account | null) => {
    if (account === null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.INTERNAL_SERVER_ERROR)
    }
    const promisesArray: Array<Promise<any>> = []

    account.recommendedMoviesHistory.forEach((movieId: number) => {
      promisesArray.push(getMovie(movieId))
    })

    return await Promise.all(promisesArray)
  }).then((resolvedPromises) => {
    return res.status(StatusCodes.OK).json(resolvedPromises)
  }).catch(handleErrorOnRoute(res))
})

export default router
