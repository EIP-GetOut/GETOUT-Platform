/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

interface preferences {
  'moviesPreferences': number [] | undefined
  'booksPreferences': string [] | undefined
  'platforms': string [] | undefined
}

export type { preferences }
