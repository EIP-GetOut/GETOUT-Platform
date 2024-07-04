/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

/* eslint-disable @typescript-eslint/strict-boolean-expressions */

import logger from '@services/middlewares/logging'

import { News } from '@entities/News'

import { appDataSource } from '@config/dataSource'

async function modifyNews (newsToChange: Record<string, any>): Promise<void> {
  const newsRepository = appDataSource.getRepository(News)

  const newsArray = Object.values(newsToChange)

  for (const news of newsArray) {
    if (news.id) {
      const existingNews = await newsRepository.findOneBy({ id: news.id })
      if (existingNews != null) {
        existingNews.title = news.title || existingNews.title
        existingNews.url = news.url || existingNews.url

        await newsRepository.save(existingNews)
        logger.info(`Updated news: ${JSON.stringify(existingNews, null, 2)}`)
      } else {
        logger.warn(`News with id ${news.id} not found`)
      }
    } else {
      logger.warn(`News id is missing in the provided data: ${JSON.stringify(news, null, 2)}`)
    }
  }
}
export { modifyNews }
