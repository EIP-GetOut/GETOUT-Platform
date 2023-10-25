/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { plainToClass } from 'class-transformer'
import { validate, type ValidationError } from 'class-validator'
import { type Request, type Response, type NextFunction } from 'express'

function validateDto<T> (type: new () => T): any {
  return async (req: Request, res: Response, next: NextFunction) => {
    const dtoInstance: T = plainToClass(type, req.body)
    const dtoObject: object = plainToClass(Object, dtoInstance) // Convert back to plain object
    const errors: ValidationError[] = await validate(dtoObject)

    if (errors.length > 0) {
      const validationErrors: any = {} // Initialize as an empty object
      errors.forEach((error: ValidationError) => {
        const { property, constraints } = error
        if (property.length > 0) {
          validationErrors[property] = Object.values((constraints != null) || {}) // Assign properties to validationErrors
        }
      })

      res.status(400).json({
        message: 'Validation failed',
        errors: validationErrors
      })
    } else {
      req.body = dtoInstance
      next()
    }
  }
}

export default validateDto
