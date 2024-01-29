/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { IsOptional, IsString } from 'class-validator'

class BooksDTO {
  @IsString()
  @IsOptional()
    intitle?: string

  @IsString()
  @IsOptional()
    inauthor?: string

  @IsString()
  @IsOptional()
    inpublisher?: string

  @IsString()
  @IsOptional()
    subject?: string

  @IsString()
  @IsOptional()
    printType?: string

  @IsString()
  @IsOptional()
    orderBy?: string

  @IsString()
  @IsOptional()
    pagination?: string
}

export { BooksDTO }
