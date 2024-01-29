/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'
import { type Response } from 'node-fetch'

import logger from '@services/middlewares/logging'
import { AccountDoesNotExistError, ApiError, AppError, BookNotInListError, DbError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { type BookDTO } from '@routes/book.dto'

import { appDataSource } from '@config/dataSource'

import { findEntity } from './getObjects'

// eslint-disable-next-line @typescript-eslint/consistent-type-imports
const fetch = async (...args: Parameters<typeof import('node-fetch')['default']>): Promise<Response> => await import('node-fetch').then(async ({ default: fetch }) => await fetch(...args))

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

  logger.info(JSON.stringify(authorInfoArray))
  return authorInfoArray
}

async function getBook (params: BookDTO): Promise<Response> {
  const query = params.id
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

const addBookToReadingList = async (accountId: UUID, movieId: string): Promise<string[]> =>
  await addBookToList(accountId, movieId, 'readingList')

const addBookToLikedBooks = async (accountId: UUID, movieId: string): Promise<string[]> =>
  await addBookToList(accountId, movieId, 'likedBooks')

const addBookToDislikedBooks = async (accountId: UUID, movieId: string): Promise<string[]> =>
  await addBookToList(accountId, movieId, 'dislikedBooks')

const removeBookFromReadingList = async (accountId: UUID, movieId: string): Promise<string[]> =>
  await removeBookFromList(accountId, movieId, 'readingList')

const removeBookFromLikedBooks = async (accountId: UUID, movieId: string): Promise<string[]> =>
  await removeBookFromList(accountId, movieId, 'likedBooks')

const removeBookFromDislikedBooks = async (accountId: UUID, movieId: string): Promise<string[]> =>
  await removeBookFromList(accountId, movieId, 'dislikedBooks')

export {
  addBookToDislikedBooks,
  addBookToLikedBooks,
  addBookToReadingList,
  getBook,
  getPictures,
  removeBookFromDislikedBooks,
  removeBookFromLikedBooks,
  removeBookFromReadingList
}
