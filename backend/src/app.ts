/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import express, { Application } from 'express'

import logger from '@middlewares/logging'

import { useRoutes, useMiddlewares } from '@services/utils/appUtils/appUtils'

import { AppDataSource } from '@config/dataSource'

(() => {
  const app: Application = express()
  const port: string | undefined = process.env.PORT

  AppDataSource.initialize().then(() => {
    logger.info("Data Source has been initialized!")
    useMiddlewares(app)
    useRoutes(app)

    app.listen(port, () => {
      logger.info(`App listening at http://localhost:${port}`)
    })
  }).catch((err) => {
    logger.error("Error during Data Source initialization:", err)
  })
})()
