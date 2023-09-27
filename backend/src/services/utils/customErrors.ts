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
    this.name = this.constructor.name
    this.status = status ?? this.status
  }

  status: StatusCodes = StatusCodes.INTERNAL_SERVER_ERROR
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

class DbError extends AppError {}

class MovieDbError extends AppError {}

class NotLoggedInError extends AppError {
  constructor (message?: string, status?: StatusCodes) {
    super(message ?? 'User is not logged in.', status ?? StatusCodes.BAD_REQUEST)
  }
}

export {
  AccountAlreadyExistError,
  AccountDoesNotExistError,
  AlreadyLoggedInError,
  ApiError,
  AppError,
  BcryptError,
  DbError,
  MovieDbError,
  NotLoggedInError
}
