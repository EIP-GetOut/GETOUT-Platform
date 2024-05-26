/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import axios from 'axios'
import { Router, type Request, type Response } from 'express'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import caching from '@middlewares/caching'
import logger, { logApiRequest } from '@middlewares/logging'

const router: Router = Router()
/**
 * @swagger
 * /:
 *   get:
 *     summary: Basic endpoint
 *     description: Welcome to GetOut API
 *     responses:
 *       200:
 *         description: A welcoming message.
 */
router.get('/', caching(24 * 60 * 60), logApiRequest, (req: Request, res: Response): void => {
  const owner = 'EIP-GetOut' // Replace with your GitHub username or organization name
  const repo = 'GETOUT-Platform' // Replace with your GitHub repository name

  axios.get(`https://api.github.com/repos/${owner}/${repo}/tags`)
    .then((response) => {
      const firstTag = response.data[0]?.name // Get the name of the first tag or undefined if no tags exist
      if (firstTag !== null) {
        res.status(StatusCodes.OK).json({ tag: firstTag })
      } else {
        res.status(StatusCodes.NOT_FOUND).json({ error: 'No tags found' })
      }
    })
    .catch((error) => {
      console.error(error)
      res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ error: 'Internal Server Error' })
    })
})

router.use((req: Request, res: Response) => {
  logger.warn(`${req.method} ${req.url} : Route not found`)
  res.status(StatusCodes.NOT_FOUND)
    .send(getReasonPhrase(StatusCodes.NOT_FOUND))
})

router.use((err: Error, req: Request, res: Response) => {
  logger.error(err.stack)
  res.status(StatusCodes.INTERNAL_SERVER_ERROR)
    .send(getReasonPhrase(StatusCodes.INTERNAL_SERVER_ERROR))
})

export default router
