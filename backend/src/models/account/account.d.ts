/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

export interface accountRepositoryRequest {
  salt: string
  email: string
  password: string
  lastName: string
  firstName: string
  bornDate: Date
}
