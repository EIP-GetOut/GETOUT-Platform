/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { books, type books_v1 } from '@googleapis/books'
import { type UUID } from 'crypto'
import { type Session, type SessionData } from 'express-session'
import { StatusCodes } from 'http-status-codes'
import { type Response } from 'node-fetch'

import { AccountDoesNotExistError, ApiError, type AppError, BookNotInListError, DbError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

// eslint-disable-next-line @typescript-eslint/consistent-type-imports
const fetch = async (...args: Parameters<typeof import('node-fetch')['default']>): Promise<Response> => await import('node-fetch').then(async ({ default: fetch }) => await fetch(...args))

const booksApi = books('v1')

const key = 'AIzaSyDDxf1nRkG6eMcufxYp2LHIWgA-2MEMlK8'

function formatAuthorQuery (author: any): any {
  return author.replace(/\s+/g, '+')
}

async function fetchAuthorInfo (author: any): Promise<any> {
  const formattedAuthor = formatAuthorQuery(author)
  const apiUrl = `https://kgsearch.googleapis.com/v1/entities:search?query=${formattedAuthor}&key=${key}`

  try {
    const response = await fetch(apiUrl)
    const data = await response.json()

    const imageLink = data.itemListElement[0]?.result?.image?.contentUrl

    return { author, imageLink }
  } catch (error) {
    console.error(`Error fetching data for ${author}:`, error)
    return { author, imageLink: null }
  }
}

async function getPictures (authors: any): Promise<any> {
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

async function getBook (id: string): Promise<any> {
  return await getBookDetails(id).then(async (book: books_v1.Schema$Volume) => {
    const volumeInfo = book.volumeInfo!
    const saleInfo = book.saleInfo!

    return ({
      id,
      title: volumeInfo.title,
      overview: volumeInfo.description,
      poster_path: volumeInfo.imageLinks?.thumbnail ?? null,
      backdrop_path: volumeInfo.imageLinks?.extraLarge ?? null,
      pageCount: volumeInfo.pageCount,
      authors: volumeInfo.authors,
      authors_picture: await getPictures(volumeInfo.authors),
      category: volumeInfo?.categories ?? null,
      vote_average: volumeInfo.averageRating ?? null,
      release_date: volumeInfo.publishedDate ?? null,
      book_link: volumeInfo.infoLink ?? saleInfo?.buyLink ?? null
    })
  }).catch((error: any) => {
    throw error
  })
}

async function addBookToList (accountId: UUID, bookId: string, bookList: keyof Account): Promise<string[]> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (!(account[bookList] as string []).includes(bookId)) {
      (account[bookList] as string []).push(bookId)
    }
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount == null) {
      throw new DbError('Failed adding book to the reading list.')
    }
    return savedAccount[bookList] as string []
  })
}

async function removeBookFromList (accountId: UUID, bookId: string, bookList: keyof Account): Promise<string[]> {
  return await findEntity<Account>(Account, { id: accountId }).then(async (account) => {
    if (account == null) {
      throw new AccountDoesNotExistError(undefined, StatusCodes.NOT_FOUND)
    }
    if (!(account[bookList] as string []).includes(bookId)) {
      throw new BookNotInListError()
    }
    (account[bookList] as string []) = (account[bookList] as string []).filter(id => id !== bookId)
    return await appDataSource.getRepository<Account>('Account').save(account)
  }).then((savedAccount: Account | null) => {
    if (savedAccount == null) {
      throw new DbError('Failed adding book to the watchlist.')
    }
    return savedAccount[bookList] as string []
  })
}

const addBookToReadingList = async (accountId: UUID, bookId: string): Promise<string[]> =>
  await addBookToList(accountId, bookId, 'readingList')

const addBookToLikedBooks = async (accountId: UUID, bookId: string, session: Session & Partial<SessionData>): Promise<string[]> => {
  return await addBookToList(accountId, bookId, 'likedBooks').then(async (likedBooks: string []) => {
    return await removeBookFromDislikedBooks(accountId, bookId).then((dislikedBooks: string[]) => {
      session.account!.dislikedBooks = dislikedBooks
      return likedBooks
    }).catch((err: AppError) => {
      if (err instanceof BookNotInListError) {
        return likedBooks
      } else {
        throw err
      }
    })
  })
}

const addBookToDislikedBooks = async (accountId: UUID, bookId: string, session: Session & Partial<SessionData>): Promise<string[]> => {
  return await addBookToList(accountId, bookId, 'dislikedBooks').then(async (dislikedBooks: string []) => {
    return await removeBookFromLikedBooks(accountId, bookId).then((likedBooks: string[]) => {
      session.account!.likedBooks = likedBooks
      return dislikedBooks
    }).catch((err: AppError) => {
      if (err instanceof BookNotInListError) {
        return dislikedBooks
      } else {
        throw err
      }
    })
  })
}

const addBookToReadBooks = async (accountId: UUID, bookId: string): Promise<string[]> =>
  await addBookToList(accountId, bookId, 'readBooks')

const removeBookFromReadingList = async (accountId: UUID, bookId: string): Promise<string[]> =>
  await removeBookFromList(accountId, bookId, 'readingList')

const removeBookFromLikedBooks = async (accountId: UUID, bookId: string): Promise<string[]> =>
  await removeBookFromList(accountId, bookId, 'likedBooks')

const removeBookFromDislikedBooks = async (accountId: UUID, bookId: string): Promise<string[]> =>
  await removeBookFromList(accountId, bookId, 'dislikedBooks')

const removeBookFromReadBooks = async (accountId: UUID, bookId: string): Promise<string[]> =>
  await removeBookFromList(accountId, bookId, 'readBooks')

export {
  addBookToDislikedBooks,
  addBookToLikedBooks,
  addBookToReadBooks,
  addBookToReadingList,
  getBook,
  getPictures,
  removeBookFromDislikedBooks,
  removeBookFromLikedBooks,
  removeBookFromReadBooks,
  removeBookFromReadingList
}
