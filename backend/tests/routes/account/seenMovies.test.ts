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
  email: 'seenMovies@test.com',
  firstName: 'Super',
  lastName: 'Tester',
  bornDate: '07/06/2001',
  password: 'toto'
}

const loginBody = {
  email: 'seenMovies@test.com',
  password: 'toto'
}

void describe('Seen movies list routes', async () => {
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

  it('should respond with 201 CREATED and the seen movies for POST /account/:accountId/seenMovies', async () => {
    await request(app).post(`/account/${accountId}/seenMovies`).send({ movieId: 41 }).set('Cookie', cookie)
      .then((response) => {
        expect(response.status).toBe(StatusCodes.CREATED)
        expect(response.body).toContain(41)
      })
  })

  it('should respond with 200 OK and the seen movies for GET /account/:accountId/seenMovies', async () => {
    await request(app).post(`/account/${accountId}/seenMovies`).send({ movieId: 42 }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).get(`/account/${accountId}/seenMovies`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).toContain(42)
      })
  })

  it('should respond with 200 OK and the seen movies for DELETE /account/:accountId/seenMovies/43', async () => {
    await request(app).post(`/account/${accountId}/seenMovies`).send({ movieId: 43 }).set('Cookie', cookie)
      .then(async () => {
        return await request(app).delete(`/account/${accountId}/seenMovies/43`).set('Cookie', cookie)
      }).then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body).not.toContain(43)
      })
  })
})
