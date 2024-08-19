/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response } from 'express'
import { Router } from 'express'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getAccountsCreatedWeekBeforeLast } from '@models/stats/accounts'

const router = Router()

/**
 * @swagger
 * /stats/accounts:
 *   get:
 *     summary: Get number of accounts created week before last
 *     description: Retrieve the number of accounts that were created the week before last.
 *     responses:
 *       200:
 *         description: Number of accounts created retrieved successfully
 *         schema:
 *               type: object
 *               properties:
 *                 numberOfAccounts:
 *                   type: integer
 *                   description: Number of accounts created the week before last
 *                   example: 42
 *       500:
 *         description: Internal server error
 *         schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: An error occurred while retrieving the data.
 */

router.get('/stats/accounts', logApiRequest, (req: Request, res: Response) => {
  getAccountsCreatedWeekBeforeLast().then(async (numberOfAccounts: number) => {
    return res.status(StatusCodes.OK).json({ numberOfAccounts })
  }).catch(handleErrorOnRoute(res))
})

export default router
