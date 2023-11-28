/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

/* eslint-disable @typescript-eslint/consistent-type-assertions */

import cors from 'cors'
import express, { type Application } from 'express'
import { generateSwaggerDoc } from 'generateSwagger'

import logger from '@middlewares/logging'

import { useRoutes, useMiddlewares, useSession } from '@services/utils/appUtils/appUtils'

import { appDataSource } from '@config/dataSource'

function checkRequiredEnvironmentVariables (): void {
  const missingEnvVariables: string [] = []
  const envVariablesToCheck: string [] = [
    'NODE_ENV',
    'PORT',
    'ORIGIN_PATTERN',
    'LOG_FILENAME',
    'SESSION_SECRET',
    'TYPEORM_PORT',
    'TYPEORM_HOST',
    'TYPEORM_USERNAME',
    'TYPEORM_PASSWORD',
    'TYPEORM_DATABASE',
    'GOOGLE_CLIENT_ID'
  ]

  envVariablesToCheck.forEach((envVar: keyof NodeJS.ProcessEnv) => {
    if (process.env[envVar] == null) {
      missingEnvVariables.push(envVar.toString())
    }
  })
  if (missingEnvVariables.length !== 0) {
    logger.error(`One or multiple environment variable is missing: (${missingEnvVariables.join(',')}).`)
    process.exit(0)
  }
}

(() => {
  checkRequiredEnvironmentVariables()
  const app: Application = express()
  const port: number = process.env.PORT
  // const allowedOrigins: string[] = ['*']
  // const corsOptions: cors.CorsOptions = {
  //   origin: (origin, callback) => {
  //     if (origin == null || allowedOrigins.includes(origin)) {
  //       callback(null, true)
  //     } else {
  //       callback(new Error('Not allowed by CORS'))
  //     }
  //   }
  // }

  generateSwaggerDoc('./src/swagger.yaml')
  appDataSource.initialize().then(() => {
    app.use(cors())
    logger.info('Data Source has been initialized!')
    generateSwaggerDoc('./src/swagger.yaml')

    useSession(app)
    useMiddlewares(app)
    useRoutes(app)

    app.listen(port, () => {
      logger.info(`App listening in ${process.env.NODE_ENV} environment at http://localhost:${port}`)
    })
  }).catch((err) => {
    logger.error('Error during Data Source initialization:', err)
  })
})()
