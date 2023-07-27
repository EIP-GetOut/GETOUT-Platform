/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { validate, ValidationError } from 'class-validator';
import { Request, Response, NextFunction } from 'express';

export const createDtoValidationMiddleware = (dtoClass: any) => {
  return async (req: Request, res: Response, next: NextFunction) => {
    try {
      const dto = Object.assign(new dtoClass(), req.body);
      const errors: ValidationError[] = await validate(dto);

      if (errors.length > 0) {
        return res.status(400).json({ errors: formatValidationErrors(errors) });
      }
    } catch (error) {
      console.error('DTO validation error:', error);
      res.status(500).send('Something went wrong!');
    }
  };
};

const formatValidationErrors = (errors: ValidationError[]) => {
  return errors.map((error) => {
    const constraints = Object.values(error.constraints || {});
    return { property: error.property, constraints };
  });
};
