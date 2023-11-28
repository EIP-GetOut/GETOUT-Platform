/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { expect, it } from '@jest/globals'
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
  it.only('should respond with 201 CREATED and the reading list for POST /account/:accountId/readingList', async () => {
    let accountId: UUID
    let cookie: string
    await request(app).post('/account/login').send(loginBody).then(async (res) => {
      const optionalCookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (optionalCookie === null) { throw Error('Failed extracting cookie') }
      cookie = optionalCookie
      return await request(app).get('/session').set('Cookie', cookie)
    }).then(async (res) => {
      accountId = res.body.account.id
      return await request(app).post(`/account/${accountId}/readingList`).send({ bookId: '_LettPDhwR0C' }).set('Cookie', cookie)
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.CREATED)
      expect(response.body).toContain('_LettPDhwR0C')
    })
  })
})
