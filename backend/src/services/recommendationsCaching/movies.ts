/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type UUID } from 'crypto'

import logger from '@services/middlewares/logging'
import { type MovieResponse } from '@services/tmdb/getMovie'
import { CacheError } from '@services/utils/customErrors'
import { getRedisClient } from '@services/utils/redisClient'

import { type MovieRecommandationAlgorithmResonse, generateMoviesRecommendations, retreiveFullRecommendationsFromIds } from '@models/account/recommendMovies'

const redisClient = getRedisClient()

export async function getCurrentRecommendations (userId: UUID): Promise<MovieResponse [] | null> {
  return await redisClient.get(`recommendation:movies:current:${userId}`).then((data) => {
    return data != null ? JSON.parse(data) as MovieResponse[] : null
  }).catch((err) => {
    throw new CacheError(`Failed to get current recommendations for user ${userId}: ${err}`)
  })
}

export async function getNextRecommendations (userId: UUID): Promise<MovieResponse [] | null> {
  return await redisClient.get(`recommendation:movies:next:${userId}`).then((data) => {
    return data != null ? JSON.parse(data) as MovieResponse[] : null
  }).catch((err) => {
    throw new CacheError(`Failed to get next recommendations for user ${userId}: ${err}`)
  })
}

export async function preloadFirstRecommendations (userId: UUID): Promise<void> {
  await generateMoviesRecommendations(userId).then(async (recommendations: MovieRecommandationAlgorithmResonse []) => {
    return await retreiveFullRecommendationsFromIds(recommendations.map((recommendation) => recommendation.id))
  }).then(async (fullRecommendations: MovieResponse []) => {
    await setCurrentRecommendations(userId, fullRecommendations)
  }).catch((err) => {
    throw new CacheError(`Failed to preload first recommendations for user ${userId}: ${err}`)
  })
}

export async function preloadNextRecommendations (userId: UUID): Promise<void> {
  await generateMoviesRecommendations(userId).then(async (recommendations: MovieRecommandationAlgorithmResonse []) => {
    return await retreiveFullRecommendationsFromIds(recommendations.map((recommendation) => recommendation.id))
  }).then(async (fullRecommendations: MovieResponse []) => {
    await setNextRecommendations(userId, fullRecommendations)
  }).catch((err) => {
    throw new CacheError(`Failed to preload next recommendations for user ${userId}: ${err}`)
  })
}

export async function setCurrentRecommendations (
  userId: UUID,
  data: MovieResponse [],
  ttl: number = 86400
): Promise<void> {
  await redisClient.set(
    `recommendation:movies:current:${userId}`,
    JSON.stringify(data), { EX: ttl }
  ).then(() => {
    logger.debug('Current movies recommendations have been set in the cache.')
  }).catch((err) => {
    throw new CacheError(`Failed to set current recommendations for user ${userId}: ${err}`)
  })
}

export async function setNextRecommendations (
  userId: UUID,
  data: MovieResponse [],
  ttl: number = 86400
): Promise<void> {
  await redisClient.set(
    `recommendation:movies:next:${userId}`,
    JSON.stringify(data), { EX: ttl }
  ).then(() => {
    logger.debug('Next movies recommendations have been set in the cache.')
  }).catch((err) => {
    throw new CacheError(`Failed to set next recommendations for user ${userId}: ${err}`)
  })
}
