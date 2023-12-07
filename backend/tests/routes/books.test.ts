/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { expect, it } from '@jest/globals'
import { StatusCodes } from 'http-status-codes'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

describe('Books Routes', () => {
  it('should respond with 200 OK for GET /generate-books?intitle=fleurs', async () => {
    await request(app).get('/generate-books?intitle=fleurs').then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body.books).toHaveLength(5)
    })
  })

  it('should respond with 500 Bad Request', async () => {
    await request(app).get('/generate-books').then((response) => {
      expect(response.status).toBe(StatusCodes.INTERNAL_SERVER_ERROR)
      // eslint-disable-next-line no-useless-escape
      expect(response.text).toBe('{\"name\":\"ApiError\",\"message\":\"Bad Request\"}')
    })
  })
})
