/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { StatusCodes } from 'http-status-codes'

class AppError extends Error {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'Internal Server error.')
    this.status = status ?? StatusCodes.INTERNAL_SERVER_ERROR
    this.name = this.constructor.name
  }

  status: StatusCodes
}

class AccountAlreadyExistError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'Account already exists.', status ?? StatusCodes.CONFLICT)
  }
}

class AccountDoesNotExistError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'Account does not exist.', status ?? StatusCodes.FORBIDDEN)
  }
}

class AlreadyLoggedInError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'User is already logged in.', status ?? StatusCodes.BAD_REQUEST)
  }
}
class ApiError extends AppError {}

class BcryptError extends AppError {}

class BookNotInListError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'Movie was not found in list.', status ?? StatusCodes.NOT_FOUND)
  }
}

class DbError extends AppError {}

class AuthenticationError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message, status ?? StatusCodes.UNAUTHORIZED)
  }
}

class MovieDbError extends AppError {}

class MovieNotInListError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'Movie was not found in list.', status ?? StatusCodes.NOT_FOUND)
  }
}

class NodeMailerError extends AppError {}

class NotLoggedInError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'User is not logged in.', status ?? StatusCodes.BAD_REQUEST)
  }
}

class PreferencesAlreadyExistError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'Preferences already exists.', status ?? StatusCodes.CONFLICT)
  }
}

class SamePasswordError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'Can\'t reset password with an old password.', status ?? StatusCodes.BAD_REQUEST)
  }
}

export {
  AccountAlreadyExistError,
  AccountDoesNotExistError,
  AlreadyLoggedInError,
  ApiError,
  AppError,
  AuthenticationError,
  BcryptError,
  BookNotInListError,
  DbError,
  MovieDbError,
  MovieNotInListError,
  NodeMailerError,
  NotLoggedInError,
  PreferencesAlreadyExistError,
  SamePasswordError
}
