/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { afterAll, beforeAll } from '@jest/globals'
import express, { type Application } from 'express'

import { useRoutes, useMiddlewares, useSession } from '@services/utils/appUtils/appUtils'

import { appDataSource } from '@config/dataSource'

let app: Application

let redisClient: any

beforeAll(async () => {
  app = express()
  await appDataSource.initialize().then(() => {
    redisClient = useSession(app)
    useMiddlewares(app)
    useRoutes(app)
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
