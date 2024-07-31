/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type EntityTarget, type FindOptionsRelations, type FindOptionsWhere, type ObjectLiteral, type Repository } from 'typeorm'

import { appDataSource } from '@config/dataSource'

async function findEntity<Entity extends ObjectLiteral> (
  repository: EntityTarget<Entity>,
  criterias: FindOptionsWhere<Entity>,
  relations: FindOptionsRelations<Entity> | null = null
): Promise<Entity | null> {
  const entityRepository: Repository<Entity> = appDataSource.getRepository<Entity>(repository)
  return await entityRepository.findOne({ where: criterias, relations: relations ?? undefined })
}

export { findEntity }
