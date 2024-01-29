/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { afterAll, beforeAll } from '@jest/globals'
import express, { type Application } from 'express'
import { StatusCodes } from 'http-status-codes'
import { type RedisClientType } from 'redis'
import request from 'supertest'

import { useRoutes, useMiddlewares, useSession } from '@services/utils/appUtils/appUtils'

import { appDataSource } from '@config/dataSource'

let app: Application

let redisClient: RedisClientType

const bodySignup = {
  email: 'supertester@tester.test',
  firstName: 'Super',
  lastName: 'Tester',
  bornDate: '07/06/2001',
  password: 'toto'
}

const loginBody = {
  email: 'supertester@tester.test',
  password: 'toto'
}

beforeAll(async () => {
  app = express()
  await appDataSource.initialize().then(async () => {
    redisClient = useSession(app)
    useMiddlewares(app)
    useRoutes(app)
    await request(app).post('/account/login').send(loginBody).then(async (response) => {
      if (response.status !== StatusCodes.OK) {
        await request(app).post('/account/signup').send(bodySignup)
      }
    })
  }).catch((err) => {
    console.error('Error during Data Source initialization:', err)
    process.exit(1)
  })
})

afterAll(async () => {
  await appDataSource.destroy()
  await redisClient.quit()
})

export { app }
