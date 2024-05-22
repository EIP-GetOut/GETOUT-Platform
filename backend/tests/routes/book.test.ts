/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { expect, it } from '@jest/globals'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

void describe('Book Route', () => {
  it('should respond with 200 OK for GET /book/:id', async () => {
    await request(app).get('/book/t34OAAAAIAAJ').then((response) => {
      expect(response.status).toBe(200)
      expect(response.body.book.title).toBe('Sons and Lovers')
    })
  })
})
