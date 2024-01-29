/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { IsNumber, IsOptional, IsString } from 'class-validator'

class MoviesDTO {
  @IsOptional()
  @IsString()
    region?: string

  @IsOptional()
  @IsString()
    sort_by?: string

  @IsOptional()
  @IsString()
    certification_country?: string

  @IsOptional()
  @IsString()
    certification?: string

  @IsOptional()
  @IsString()
    include_adult?: string

  @IsOptional()
  @IsString()
    include_video?: string

  @IsOptional()
  @IsString()
    page?: string

  @IsOptional()
  @IsNumber()
    primary_release_year?: number

  @IsOptional()
  @IsNumber()
    with_release_type?: number

  @IsOptional()
  @IsNumber()
    year?: number

  @IsOptional()
  @IsString()
    with_cast?: string

  @IsOptional()
  @IsString()
    with_crew?: string

  @IsOptional()
  @IsString()
    with_people?: string

  @IsOptional()
  @IsString()
    with_companies?: string

  @IsOptional()
  @IsString()
    with_genres?: string

  @IsOptional()
  @IsString()
    without_genres?: string

  @IsOptional()
  @IsString()
    with_keywords?: string

  @IsOptional()
  @IsString()
    without_keywords?: string

  @IsOptional()
  @IsString()
    with_original_language?: string

  @IsOptional()
  @IsString()
    with_watch_providers?: string

  @IsOptional()
  @IsString()
    watch_region?: string

  @IsOptional()
  @IsString()
    with_watch_monetization_types?: string
}

export { MoviesDTO }
