/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import express, { Application } from 'express'
import { generateSwaggerDoc } from 'generateSwagger'

import logger from '@middlewares/logging'

import { useRoutes, useMiddlewares, useSession } from '@services/utils/appUtils/appUtils'

import { appDataSource } from '@config/dataSource'

(() => {
  const app: Application = express()
  const port: string | undefined = process.env.PORT

  generateSwaggerDoc('./src/swagger.yaml')
  appDataSource.initialize().then(() => {
    logger.info("Data Source has been initialized!")

    useSession(app)
    useMiddlewares(app)
    useRoutes(app)

    app.listen(port, () => {
      logger.info(`App listening in ${process.env.NODE_ENV!} environment at http://localhost:${port}`)
    })
  }).catch((err) => {
    logger.error("Error during Data Source initialization:", err)
  })
})()
