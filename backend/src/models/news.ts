/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { DbError } from '@services/utils/customErrors'

import { News } from '@entities/News'

import { appDataSource } from '@config/dataSource'

async function getNews (): Promise<News []> {
  return await appDataSource.getRepository(News).find().then((news: News []) => {
    return news
  })
}

interface newsPatchingRequest {
  id: number
  title: string
  url: string
  image: string
}

async function modifyNews (newsToChange: newsPatchingRequest []): Promise<void> {
  const newsRepository = appDataSource.getRepository(News)
  const promisesArray: Array<Promise<any>> = []

  newsToChange.forEach((news) => {
    newsRepository.findOneBy({ id: news.id }).then((foundNews) => {
      if (foundNews == null) {
        promisesArray.push(newsRepository.save(news))
        return
      }
      foundNews.title = news.title
      foundNews.url = news.url
      foundNews.image = news.image
      promisesArray.push(newsRepository.save(foundNews))
    }).catch((err) => {
      throw new DbError(err)
    })
  })
  await Promise.all(promisesArray)
}

export { getNews, modifyNews }
