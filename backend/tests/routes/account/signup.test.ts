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

const body = {
  email: 'user' + Math.floor(Math.random() * 1e6) + '@example.com',
  firstName: 'Random',
  lastName: 'User',
  bornDate: '07/06/2001',
  password: 'toto'
}

describe('User Routes', () => {
  it('should respond with 200 OK for POST /account/signup', async () => {
    await request(app).post('/account/signup').send(body).then((response) => {
      expect(response.status).toBe(StatusCodes.CREATED)
      expect(response.body.email).toStrictEqual(body.email)
    })
  })
})
