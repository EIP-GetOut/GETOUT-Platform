/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'

import { type BookResponse } from '@services/googlebooks/getBook'
import logger from '@services/middlewares/logging'
import { CacheError } from '@services/utils/customErrors'
import { getRedisClient } from '@services/utils/redisClient'

import {
  type BookRecommandationAlgorithmResonse,
  generateBooksRecommendations,
  retreiveFullRecommendationsFromIds
} from '@models/account/recommendBooks'

const redisClient = getRedisClient()

export async function getCurrentRecommendations (userId: UUID): Promise<BookResponse [] | null> {
  return await redisClient.get(`recommendation:books:current:${userId}`).then((data) => {
    return data != null ? JSON.parse(data) as BookResponse[] : null
  }).catch((err) => {
    throw new CacheError(`Failed to get current recommendations for user ${userId}: ${err}`)
  })
}

export async function getNextRecommendations (userId: UUID): Promise<BookResponse [] | null> {
  return await redisClient.get(`recommendation:books:next:${userId}`).then((data) => {
    return data != null ? JSON.parse(data) as BookResponse[] : null
  }).catch((err) => {
    console.error(`Failed to get next recommendations for user ${userId}: ${err}`)
    throw err
  })
}

export async function preloadFirstRecommendations (userId: UUID): Promise<void> {
  await generateBooksRecommendations(userId).then(async (recommendations: BookRecommandationAlgorithmResonse []) => {
    return await retreiveFullRecommendationsFromIds(recommendations.map((recommendation) => recommendation.id))
  }).then(async (fullRecommendations: BookResponse []) => {
    await setCurrentRecommendations(userId, fullRecommendations)
  }).catch((err) => {
    throw new CacheError(`Failed to preload first recommendations for user ${userId}: ${err}`)
  })
}

export async function preloadNextRecommendations (userId: UUID): Promise<void> {
  await generateBooksRecommendations(userId).then(async (recommendations: BookRecommandationAlgorithmResonse []) => {
    return await retreiveFullRecommendationsFromIds(recommendations.map((recommendation) => recommendation.id))
  }).then(async (fullRecommendations: BookResponse []) => {
    await setNextRecommendations(userId, fullRecommendations)
  }).catch((err) => {
    throw new CacheError(`Failed to preload next recommendations for user (${userId}: ${err})`)
  })
}

export async function setCurrentRecommendations (
  userId: UUID,
  data: BookResponse [],
  ttl: number = 86400
): Promise<void> {
  await redisClient.set(
    `recommendation:books:current:${userId}`,
    JSON.stringify(data), { EX: ttl }
  ).then(() => {
    logger.debug('Current books recommendations have been set in the cache.')
  }).catch((err) => {
    throw new CacheError(`Failed to set current recommendations for user ${userId}: ${err}`)
  })
}

export async function setNextRecommendations (
  userId: UUID,
  data: BookResponse [],
  ttl: number = 86400
): Promise<void> {
  await redisClient.set(
    `recommendation:books:next:${userId}`,
    JSON.stringify(data), { EX: ttl }
  ).then(() => {
    logger.debug('Next books recommendations have been set in the cache.')
  }).catch((err) => {
    throw new CacheError(`Failed to set next recommendations for user ${userId}: ${err}`)
  })
}
