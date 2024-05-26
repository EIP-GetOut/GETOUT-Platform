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
  email: 'watchlist@test.com',
  firstName: 'Super',
  lastName: 'Tester',
  bornDate: '07/06/2001',
  password: 'toto'
}

const loginBody = {
  email: 'watchlist@test.com',
  password: 'toto'
}

void describe('Reading List Route', async () => {
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

  it('should respond with 201 CREATED and the watchlist for POST /account/:accountId/watchlist', async () => {
    await request(app).post(`/account/${accountId}/watchlist`).send({ movieId: 69 }).set('Cookie', cookie)
      .then((response) => {
        expect(response.status).toBe(StatusCodes.CREATED)
        expect(response.body).toContain(69)
      })
  })

  it('should respond with 200 OK and the watchlist for GET /account/:accountId/watchlist', async () => {
    await request(app).post(`/account/${accountId}/watchlist`).send({ movieId: 70 }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).get(`/account/${accountId}/watchlist`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).toContain(70)
      })
  })

  it('should respond with 200 OK and the watchlist for DELETE /account/:accountId/watchlist/71', async () => {
    await request(app).post(`/account/${accountId}/watchlist`).send({ movieId: 71 }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).delete(`/account/${accountId}/watchlist/71`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).not.toContain(71)
      })
  })
})
