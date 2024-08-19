/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { type UUID } from 'crypto'
import { StatusCodes } from 'http-status-codes'

import { AccountDoesNotExistError, type AppError, BookNotInListError, DbError } from '@services/utils/customErrors'

import { Account } from '@entities/Account'

import { appDataSource } from '@config/dataSource'

import { modifyAccount } from './account'
import { findEntity } from './getObjects'

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

const addBookToLikedBooks = async (accountId: UUID, bookId: string): Promise<string[]> => {
  return await addBookToList(accountId, bookId, 'likedBooks').then(async (likedBooks: string []) => {
    return await removeBookFromDislikedBooks(accountId, bookId).then(async (dislikedBooks: string[]) => {
      await modifyAccount(accountId, { dislikedBooks })
    }).then(() => {
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

const addBookToDislikedBooks = async (accountId: UUID, bookId: string): Promise<string[]> => {
  return await addBookToList(accountId, bookId, 'dislikedBooks').then(async (dislikedBooks: string []) => {
    return await removeBookFromLikedBooks(accountId, bookId).then(async (likedBooks: string[]) => {
      await modifyAccount(accountId, { likedBooks })
    }).then(() => {
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
  removeBookFromDislikedBooks,
  removeBookFromLikedBooks,
  removeBookFromReadBooks,
  removeBookFromReadingList
}
