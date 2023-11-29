/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { IsNumber } from 'class-validator'

class BookDTO {
  @IsNumber()
    id?: number
}

export { BookDTO }
