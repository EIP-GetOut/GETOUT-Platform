/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Response } from 'express'
import { StatusCodes } from 'http-status-codes'

import logger from '@services/middlewares/logging'

import { AppError } from './customErrors'

export function handleErrorOnRoute (res: Response) {
  return (err: AppError | Error) => {
    logger.error(`${err.name}: ${err.message}`)
    res.status((err instanceof AppError ? err.status : StatusCodes.INTERNAL_SERVER_ERROR)).send({ name: err.name, message: err.message })
  }
}
