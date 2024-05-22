/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type AppError, PermissionsError } from '@services/utils/customErrors'

import { Permission } from '@entities/Permissions'

import { findEntity } from './getObjects'
const accoutHasPermission = async (accoutPermissions: bigint, permissionName: string): Promise<boolean> => {
  return await findEntity<Permission>(Permission, { name: permissionName }).then((permission: any) => {
    if (permission != null) {
      console.log('permission not found:', permissionName)
      return (false)
    }
    console.log('PERMISSION FOUND:', permission)
    return (Boolean(accoutPermissions & permission.bit))
  }).catch((err: Error | AppError) => {
    throw new PermissionsError(err.message)
  })
}

export { accoutHasPermission }
