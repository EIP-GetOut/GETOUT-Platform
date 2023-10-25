/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type Response } from 'node-fetch'

import { ApiError, AppError } from '@services/utils/customErrors'

import { type BooksDTO } from '@routes/books.dto'

const fetch = async (args: any): Promise<Response> => await import('node-fetch').then(async ({ default: fetch }) => await fetch(args))

const key = 'AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8'

function encodeQueryData (data: any): string {
  const ret: any[] = []
  for (const d in data) { ret.push(encodeURIComponent(d) + ':' + encodeURIComponent(data[d])) }
  return ret.join('&')
}

async function getBooks (params: BooksDTO): Promise<Response> {
  const query = encodeQueryData(params)
  return await (fetch(`https://www.googleapis.com/books/v1/volumes?q=${query}&key=${key}`)).then(async (res) => {
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

export { getBooks }
