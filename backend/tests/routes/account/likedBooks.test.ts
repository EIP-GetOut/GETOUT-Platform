/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { beforeAll, expect, it } from '@jest/globals'
import { StatusCodes } from 'http-status-codes'
import { type UUID } from 'node:crypto'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

import { extractConnectSidCookie } from '../../utils_funcs'

const loginBody = {
  email: 'supertester@tester.test',
  password: 'toto'
}

describe('Reading List Route', async () => {
  let accountId: UUID
  let cookie: string

  beforeAll(async () => {
    await request(app).post('/account/login').send(loginBody).then(async (res) => {
      const optionalCookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (optionalCookie === null) { throw Error('Failed extracting cookie') }
      cookie = optionalCookie
      return await request(app).get('/session').set('Cookie', cookie)
    }).then((res) => {
      accountId = res.body.account.id
    })
  })

  it('should respond with 201 CREATED and the liked books list for POST /account/:accountId/likedBooks', async () => {
    await request(app).post(`/account/${accountId}/likedBooks`).send({ bookId: '_LettPDhwR0C' }).set('Cookie', cookie)
      .then((response) => {
        expect(response.status).toBe(StatusCodes.CREATED)
        expect(response.body).toContain('_LettPDhwR0C')
      })
  })

  it('should respond with 200 OK and the liked books list for GET /account/:accountId/likedBooks', async () => {
    await request(app).post(`/account/${accountId}/likedBooks`).send({ bookId: '_LettPDhwR0C' }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).get(`/account/${accountId}/likedBooks`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).toContain('_LettPDhwR0C')
      })
  })

  it('should respond with 200 OK and the liked books list for DELETE /account/:accountId/likedBooks/42', async () => {
    await request(app).post(`/account/${accountId}/likedBooks`).send({ bookId: '_LettPDhwR0C' }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).delete(`/account/${accountId}/likedBooks/_LettPDhwR0C`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).not.toContain('_LettPDhwR0C')
      })
  })
})
