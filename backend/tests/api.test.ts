/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { afterAll, beforeAll, expect, it } from '@jest/globals'
import express, { type Application } from 'express'
import { type Server } from 'node:http'
import { describe } from 'node:test'
import request from 'supertest'

import { useRoutes, useMiddlewares, useSession } from '@services/utils/appUtils/appUtils'

import { appDataSource } from '@config/dataSource'

let app: Application
{
  let server: Server
  let redisClient: any

  beforeAll((done) => {
    app = express()
    const port: string | undefined = process.env.PORT
    appDataSource.initialize().then(() => {
      redisClient = useSession(app)
      useMiddlewares(app)
      useRoutes(app)

      server = app.listen(port, done)
    }).catch((err) => {
      console.error('Error during Data Source initialization:', err)
      process.exit(1)
    })
  })

  afterAll(async () => {
    await new Promise((resolve) => {
      server.close(() => {
        resolve(true)
      })
    })
    await appDataSource.destroy()
    await redisClient.quit()
  })
}

describe('User Routes', () => {
  it('should respond with 200 OK for GET /', async () => {
    await request(app).get('/').then((response) => {
      expect(response.status).toBe(200)
      expect(response.text).toBe('OK')
    })
  })

  it('should respond with 404 Not Found for invalid route', async () => {
    await request(app).get('/nonexistent').then((response) => {
      expect(response.status).toBe(404)
    })
  })
})

describe('Session route', () => {
  it('should respond with 200 OK for GET /session', async () => {
    await request(app).get('/session').then((response) => {
      expect(response.status).toBe(200)
      expect(response.body).toHaveProperty('cookie')
    })
  })
})
