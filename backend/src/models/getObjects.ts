/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { EntityTarget, FindOptionsRelations, FindOptionsWhere, ObjectLiteral, Repository } from 'typeorm'

import { appDataSource } from '@config/dataSource'

function findEntity<Entity extends ObjectLiteral>(
  repository: EntityTarget<Entity>,
  criterias: FindOptionsWhere<Entity>,
  relations: FindOptionsRelations<Entity> | null = null
): Promise<Entity | null> {
  const entityRepository: Repository<Entity> = appDataSource.getRepository<Entity>(repository)
  return entityRepository.findOneBy(criterias)
}

export { findEntity }
