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

describe('Movie Route', () => {
  it('should respond with 200 OK for GET /movie/:id', async () => {
    await request(app).get('/movie/951491').then((response) => {
      expect(response.status).toBe(200)
      expect(response.body.movie.title).toBe('Saw X')
    })
  })
})
