/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { expect, it } from '@jest/globals'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

import { extractConnectSidCookie } from '../setupUtils'

const loginBody = {
  email: 'supertester@test.com',
  password: 'toto'
}

void describe('Session route', () => {
  it('should respond with 200 OK for GET /session with authentified account', async () => {
    let cookie: string
    await request(app).post('/account/login').send(loginBody).then(async (res) => {
      const optionalCookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (optionalCookie === null) { throw Error('Failed extracting cookie') }
      cookie = optionalCookie
      return await request(app).get('/session').set('Cookie', cookie)
    }).then(async (response) => {
      expect(response.status).toBe(200)
      expect(response.body).toHaveProperty('cookie')
      expect(response.body).toHaveProperty('account')
      expect(response.body.account.email).toStrictEqual(loginBody.email)
    })
  })

  it('should respond with 200 OK for GET /session', async () => {
    await request(app).get('/session').then((response) => {
      expect(response.status).toBe(200)
      expect(response.body).toHaveProperty('cookie')
      expect(response.body.account).toBeFalsy()
    })
  })
})
