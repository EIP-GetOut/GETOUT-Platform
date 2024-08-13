/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { books, type books_v1 } from '@googleapis/books'
import { StatusCodes } from 'http-status-codes'

import { ApiError } from '@services/utils/customErrors'

export interface BookResponse {
  id?: string
  title: string
  averageRating: number | null
  releaseDate: string // formated 'YYYY'
  categories: string [] | null
  posterPath: string
  backdropPath: string | null
  pageCount: number | null
  description: string | null
  authors: string [] | null
  link: string
}

const booksApi = books('v1')
const key = process.env.GOOGLE_BOOKS_API_KEY

async function getBookDetails (id: string): Promise<books_v1.Schema$Volume> {
  return await booksApi.volumes.get({ volumeId: id, key }).then((res) => {
    if (res.status !== StatusCodes.OK || res?.data?.volumeInfo == null || res.data.saleInfo == null) {
      throw new ApiError(`Error whiled obtaining book ${id}'s details (${res.status}: ${res.statusText}).`)
    }
    return res.data
  })
}

async function getBook (id: string, withDetails: boolean = false): Promise<BookResponse> {
  return await getBookDetails(id).then(async (book: books_v1.Schema$Volume) => {
    const volumeInfo = book.volumeInfo!
    const saleInfo = book.saleInfo!

    if (withDetails) {
      return ({
        id,
        title: volumeInfo.title,
        averageRating: volumeInfo.averageRating ?? null,
        releaseDate: volumeInfo.publishedDate,
        categories: volumeInfo?.categories ?? null,
        posterPath: volumeInfo.imageLinks?.thumbnail,
        backdropPath: volumeInfo.imageLinks?.extraLarge ?? null,
        pageCount: volumeInfo.pageCount ?? null,
        description: volumeInfo.description ?? null,
        authors: volumeInfo.authors ?? null,
        link: volumeInfo.infoLink ?? saleInfo?.buyLink
      }) satisfies Partial<BookResponse>
    }
    return ({
      id,
      title: volumeInfo.title,
      averageRating: volumeInfo.averageRating ?? null,
      releaseDate: volumeInfo.publishedDate,
      categories: volumeInfo?.categories ?? null,
      posterPath: volumeInfo.imageLinks?.thumbnail,
      backdropPath: volumeInfo.imageLinks?.extraLarge ?? null
    }) satisfies Partial<BookResponse>
  }).then((bookDetails: Partial<BookResponse>): BookResponse => {
    for (const [key, value] of Object.entries(bookDetails)) {
      if (value === undefined) {
        throw new ApiError(`Value of property ${key} is missing in Google Book response (${JSON.stringify(bookDetails, undefined, 2)}).`)
      }
    }
    const res = (bookDetails as BookResponse)
    return res satisfies BookResponse
  })
}

export { getBook }
