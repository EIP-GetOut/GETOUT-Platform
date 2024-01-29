/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { expect, it } from '@jest/globals'
import { StatusCodes } from 'http-status-codes'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

import { extractConnectSidCookie } from '../../setupUtils'

const body = {
  email: 'user' + Math.floor(Math.random() * 1e6) + '@example.com',
  firstName: 'Random',
  lastName: 'User',
  bornDate: '07/06/2001',
  password: 'toto'
}

describe('Reading List Route', async () => {
  it('should respond with 204 NO_CONTENT for POST /account/change-password', async () => {
    let cookie: string
    await request(app).post('/account/signup').send(body).then(async () => {
      return await request(app).post('/account/login').send({ email: body.email, password: body.password })
    }).then(async (res) => {
      const optionalCookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (optionalCookie === null) { throw Error('Failed extracting cookie') }
      cookie = optionalCookie
      return await request(app).post('/account/change-password').send({ password: body.password, newPassword: 'tata' }).set('Cookie', cookie)
    }).then(async (res) => {
      expect(res.statusCode).toBe(StatusCodes.NO_CONTENT)
    })
  })
})
