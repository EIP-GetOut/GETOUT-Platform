/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Response } from 'node-fetch'

import { ApiError, AppError } from '@services/utils/customErrors'

import { type BookDTO } from '@routes/book.dto'

// eslint-disable-next-line @typescript-eslint/consistent-type-imports
const fetch = async (...args: Parameters<typeof import('node-fetch')['default']>): Promise<Response> => await import('node-fetch').then(async ({ default: fetch }) => await fetch(...args))

const key = 'AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8'

async function getBook (params: BookDTO): Promise<Response> {
  const query = params.id + '&'
  return await (fetch(`https://www.googleapis.com/books/v1/volumes/${query}?key=${key}`)).then(async (res) => {
    if (!res.ok) {
      throw new ApiError(res.statusText)
    }
    return await res.json()
  }).catch((err: AppError | Error) => {
    if (err instanceof AppError) {
      throw err
    } else {
      throw new AppError()
    }
  })
}

export { getBook }
