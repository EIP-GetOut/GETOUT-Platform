/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

interface Preferences {
  'moviesGenres': number [] | undefined
  'booksGenres': string [] | undefined
  'platforms': string [] | undefined
}

export type { Preferences }
