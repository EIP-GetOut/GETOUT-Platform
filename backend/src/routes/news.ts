/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Request, type Response } from 'express'
import { Router } from 'express'
import { body } from 'express-validator'
import { StatusCodes, getReasonPhrase } from 'http-status-codes'

import caching from '@services/middlewares/caching'
import { logApiRequest } from '@services/middlewares/logging'
import validate from '@services/middlewares/validator'
import { handleErrorOnRoute } from '@services/utils/handleRouteError'

import { getNews, modifyNews } from '@models/news'

import { type News } from '@entities/News'

const router = Router()

/**
 * @swagger
 * /news:
 *   get:
 *     summary: Retrieve the list of news.
 *     description: Retrieve a JSON array containing the list of news.
 *     responses:
 *       "200":
 *         description: Successfully retrieved news list.
 *       "500":
 *         description: Internal server error.
 */
router.get('/news', caching(10 * 60), logApiRequest, (_req: Request, res: Response) => {
  getNews().then((news: News[]) => {
    return res.status(StatusCodes.OK).json(news)
  }).catch(handleErrorOnRoute(res))
})

/**
 * @swagger
 * /news:
 *   patch:
 *     summary: Modify the list of news.
 *     description: Modify the list of news with the provided array of news objects. The array should contain no more than 5 items, and each id should be unique and between 1 and 5.
 *     consumes:
 *       - application/json
 *     parameters:
 *       - in: body
 *         name: news
 *         required: true
 *         schema:
 *           type: array
 *           items:
 *             type: object
 *             properties:
 *               id:
 *                 type: integer
 *                 minimum: 1
 *                 maximum: 5
 *                 description: The id of the news item.
 *               title:
 *                 type: string
 *                 description: The title of the news item.
 *               url:
 *                 type: string
 *                 format: url
 *                 description: The URL of the news item.
 *               image:
 *                 type: string
 *                 format: url
 *                 description: The image URL of the news item.
 *     responses:
 *       "200":
 *         description: Successfully modified news.
 *       "400":
 *         description: Invalid request body or duplicate ids.
 *       "500":
 *         description: Internal server error.
 */
const rulesPatch = [
  body().isArray().withMessage('Body should be an array'),
  body().custom((value) => {
    if (value.length > 5) {
      throw new Error('Array should contain no more than 5 items')
    }
    const ids = value.map((item: any) => item.id)
    const uniqueIds = new Set(ids)
    if (uniqueIds.size !== ids.length) {
      throw new Error('Array contains duplicate ids')
    }
    return true
  }),
  body('*.id').isInt({ min: 1, max: 5 }).withMessage('id should be an integer between 1 and 5'),
  body('*.title').isString().withMessage('title should be a string'),
  body('*.url').isURL().withMessage('url should be a valid URL'),
  body('*.sourceLogo').isURL().withMessage('sourceLogo should be a valid URL'),
  body('*.image').isURL().withMessage('image should be a valid URL')
]

router.patch('/news', rulesPatch, validate, logApiRequest, (req: Request, res: Response) => {
  modifyNews(req.body).then(() => {
    return res.status(StatusCodes.OK).send(getReasonPhrase(StatusCodes.OK))
  }).catch(handleErrorOnRoute(res))
})

export default router
