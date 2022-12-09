/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { NextFunction, Request, Response } from 'express'
import { Result, ValidationError, validationResult } from 'express-validator'
import { StatusCodes } from 'http-status-codes'

const validate = (req: Request, res: Response, next: NextFunction) => {
  const errors: Result<ValidationError> = validationResult(req)
  if (errors.isEmpty()) {
    return next()
  }
  const extractedErrors: any[] = []
  errors.array().map(err => extractedErrors.push({ [err.param]: err.msg }))
  return res.status(StatusCodes.UNPROCESSABLE_ENTITY).json({
    errors: extractedErrors
  })
}

export default validate
