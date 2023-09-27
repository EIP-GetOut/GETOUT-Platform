/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import cors from 'cors'
import express, { type Application } from 'express'
import { generateSwaggerDoc } from 'generateSwagger'

import logger from '@middlewares/logging'

import { useRoutes, useMiddlewares, useSession } from '@services/utils/appUtils/appUtils'

import { appDataSource } from '@config/dataSource'

(() => {
  const app: Application = express()
  const port: string | undefined = process.env.PORT
  const allowedOrigins = ['http://localhost:3000']
  const corsOptions: cors.CorsOptions = {
    origin: (origin, callback) => {
      if (origin == null || allowedOrigins.includes(origin)) {
        callback(null, true)
      } else {
        callback(new Error('Not allowed by CORS'))
      }
    }
  }

  generateSwaggerDoc('./src/swagger.yaml')
  appDataSource.initialize().then(() => {
    app.use(cors(corsOptions))
    logger.info('Data Source has been initialized!')
    generateSwaggerDoc('./src/swagger.yaml')

    useSession(app)
    useMiddlewares(app)
    useRoutes(app)

    app.listen(port, () => {
      logger.info(`App listening in ${process.env.NODE_ENV!} environment at http://localhost:${port}`)
    })
  }).catch((err) => {
    logger.error('Error during Data Source initialization:', err)
  })
})()
