/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { createClient, type RedisClientType } from 'redis'

let redisClient: RedisClientType | null = null

export function getRedisClient (): RedisClientType {
  if (redisClient === null) {
    redisClient = createClient({ url: `redis://${process.env.NODE_ENV === 'test' ? 'localhost' : 'redis'}:6379` })
    redisClient.connect().catch(console.error)
  }
  return redisClient
}
