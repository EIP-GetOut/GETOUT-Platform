/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { beforeAll, expect, it } from '@jest/globals'
import { type UUID } from 'node:crypto'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

import { extractConnectSidCookie } from '../../setupUtils'

const loginBody = {
  email: 'supertester@tester.test',
  password: 'toto'
}

describe('Movies Routes', () => {
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

  it('should respond with 200 OK for GET /recommend-movies?with_genres=27', async () => {
    await request(app).get(`/account/${accountId}/recommend-movies?with_genres=27`).set('Cookie', cookie).then((response) => {
      expect(response.status).toBe(200)
      expect(response.body.movies).toHaveLength(5)
    })
  })
})
