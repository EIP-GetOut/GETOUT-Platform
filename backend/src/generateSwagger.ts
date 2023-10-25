/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import fs from 'fs'
import yaml from 'yaml'

import logger from '@middlewares/logging'

import swaggerSpec from '@config/swaggerConfig'

export function generateSwaggerDoc (outputFilePath: string): void {
  const yamlString = yaml.stringify(swaggerSpec)

  fs.writeFile(outputFilePath, yamlString, (err) => {
    if (err != null) {
      logger.error('Error writing Swagger YAML file:', err)
    } else {
      logger.info('Swagger YAML file generated:', outputFilePath)
    }
  })
}
