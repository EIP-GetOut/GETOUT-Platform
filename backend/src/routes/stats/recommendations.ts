/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { Router } from 'express'
import { type Request, type Response } from 'express'
import { StatusCodes } from 'http-status-codes'

import { logApiRequest } from '@services/middlewares/logging'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getNbRecommendationsThisWWeek } from '@models/stats/recommendations'

const router = Router()

/**
 * @swagger
 * /stats/recommendations:
 *   get:
 *     summary: Get number of recommendations made this week
 *     description: Retrieve the number of recommendations that were made this week.
 *     responses:
 *       200:
 *         description: Number of recommendations made this week retrieved successfully
 *         schema:
 *               type: object
 *               properties:
 *                 numberOfRecommendations:
 *                   type: integer
 *                   description: Number of recommendations made this week
 *                   example: 123
 *       500:
 *         description: Internal server error
 *         schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: An error occurred while retrieving the data.
 */

router.get('/stats/recommendations', logApiRequest, (req: Request, res: Response) => {
  getNbRecommendationsThisWWeek().then(async (numberOfRecommendations: number) => {
    return res.status(StatusCodes.OK).json({ numberOfRecommendations })
  }).catch(handleErrorOnRoute(res))
})

export default router
