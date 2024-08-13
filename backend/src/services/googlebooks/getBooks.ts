/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { books, type books_v1 } from '@googleapis/books'
import axios from 'axios'
import { StatusCodes } from 'http-status-codes'

import logger from '@services/middlewares/logging'
import { ApiError, AppError } from '@services/utils/customErrors'

interface Author {
  name: string
  imageLink: string | null
}

export interface BookResponse {
  id?: string
  title: string | undefined
  vote_average: number | undefined
  release_date: string | undefined // formated 'YYYY'
  category: string [] | undefined
  poster_path: string | undefined
  backdrop_path: string | undefined
  pageCount: number | undefined
  overview: string | undefined
  authors: Author [] | undefined
  book_link: string | undefined
}

const booksApi = books('v1')
const key = process.env.GOOGLE_BOOKS_API_KEY

function formatAuthorQuery (author: string): string {
  return author.replace(/\s+/g, '+')
}

async function fetchAuthorInfo (author: string): Promise<Author> {
  const formattedAuthor = formatAuthorQuery(author)
  const apiUrl = `https://kgsearch.googleapis.com/v1/entities:search?query=${formattedAuthor}&key=${key}`

  return await axios.get(apiUrl).then((response) => {
    const data = response.data
    const imageLink: string = data.itemListElement[0]?.result?.image?.contentUrl

    if (typeof imageLink === 'undefined') {
      throw new ApiError(`${author}'s image is undefined`)
    }
    return {
      name: author,
      imageLink
    }
  }).catch((error: AppError) => {
    logger.error(`Error fetching data for ${author}: ${error.message}`)
    return {
      name: author,
      imageLink: null
    }
  })
}

async function getPictures (authors: string[]): Promise<Author []> {
  const authorInfoPromises = authors.map(fetchAuthorInfo)
  const authorInfoArray = await Promise.all(authorInfoPromises)

  return authorInfoArray
}

async function getBookDetails (id: string): Promise<books_v1.Schema$Volume> {
  return await booksApi.volumes.get({ volumeId: id, key }).then((res) => {
    if (res.status !== StatusCodes.OK || res?.data?.volumeInfo == null || res.data.saleInfo == null) {
      throw new ApiError(`Error whiled obtaining book ${id}'s details (${res.status}: ${res.statusText}).`)
    }
    return res.data
  })
}

async function getBook (id: string, withDetails: boolean = false): Promise<BookResponse | Partial<BookResponse>> {
  return await getBookDetails(id).then(async (book: books_v1.Schema$Volume) => {
    const volumeInfo = book.volumeInfo!
    const saleInfo = book.saleInfo!

    if (withDetails) {
      return ({
        id,
        title: volumeInfo.title,
        vote_average: volumeInfo.averageRating,
        release_date: volumeInfo.publishedDate,
        category: volumeInfo?.categories,
        poster_path: volumeInfo.imageLinks?.thumbnail,
        backdrop_path: volumeInfo.imageLinks?.extraLarge,
        pageCount: volumeInfo.pageCount,
        overview: volumeInfo.description,
        authors: volumeInfo.authors === undefined ? undefined : await getPictures(volumeInfo.authors),
        book_link: volumeInfo.infoLink ?? saleInfo?.buyLink
      }) satisfies BookResponse
    } else {
      return ({
        id,
        title: volumeInfo.title,
        vote_average: volumeInfo.averageRating ?? undefined,
        release_date: volumeInfo.publishedDate ?? undefined,
        category: volumeInfo?.categories ?? undefined,
        poster_path: volumeInfo.imageLinks?.thumbnail ?? undefined,
        backdrop_path: volumeInfo.imageLinks?.extraLarge ?? undefined
      }) satisfies Partial<BookResponse>
    }
  }).then((bookDetails: BookResponse | Partial<BookResponse>) => {
    for (const [key, value] of Object.entries(bookDetails)) {
      if (value === undefined) {
        throw new ApiError(`${key} is undefined`)
      }
    }
    return (bookDetails)
  }).catch((err: Error | AppError) => {
    if (err instanceof AppError) {
      throw err
    }
    throw new ApiError('Error while getting the book details')
  })
}

export { getBook }
