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

import { extractConnectSidCookie } from '../../setupUtils'

const bodySignup = {
  email: 'readingList@test.com',
  firstName: 'Super',
  lastName: 'Tester',
  bornDate: '07/06/2001',
  password: 'toto'
}

const loginBody = {
  email: 'readingList@test.com',
  password: 'toto'
}

describe('Reading List Route', async () => {
  let accountId: UUID
  let cookie: string

  beforeAll(async () => {
    await request(app).post('/account/signup').send(bodySignup).then(async (response) => {
      if (response.statusCode !== StatusCodes.CREATED) {
        throw Error('Failed creating account')
      }
      await request(app).post('/account/login').send(loginBody).then(async (res) => {
        const optionalCookie = extractConnectSidCookie(res.headers['set-cookie'][0])
        if (optionalCookie === null) { throw Error('Failed extracting cookie') }
        cookie = optionalCookie
        return await request(app).get('/session').set('Cookie', cookie)
      }).then((res) => {
        accountId = res.body.account.id
      })
    })
  })

  it('should respond with 201 CREATED and the reading list for POST /account/:accountId/readingList', async () => {
    await request(app).post(`/account/${accountId}/readingList`).send({ bookId: 'PQgQAQAAQBAJ' }).set('Cookie', cookie)
      .then((response) => {
        expect(response.status).toBe(StatusCodes.CREATED)
        expect(response.body).toContain('PQgQAQAAQBAJ')
      })
  })

  it('should respond with 200 OK and the reading list for GET /account/:accountId/readingList', async () => {
    await request(app).post(`/account/${accountId}/readingList`).send({ bookId: 'FTDuAAAAMAAJ' }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).get(`/account/${accountId}/readingList`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).toContain('FTDuAAAAMAAJ')
      })
  })

  it('should respond with 200 OK and the reading list for DELETE /account/:accountId/readingList/7L6vhYi4Oy8C', async () => {
    await request(app).post(`/account/${accountId}/readingList`).send({ bookId: '7L6vhYi4Oy8C' }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).delete(`/account/${accountId}/readingList/7L6vhYi4Oy8C`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).not.toContain('7L6vhYi4Oy8C')
      })
  })
})
