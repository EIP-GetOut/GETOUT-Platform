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

import { extractConnectSidCookie } from '../../setupUtils'

const loginBody = {
  email: 'supertester@test.com',
  password: 'toto'
}

void describe('Verify Email Route', async () => {
  let cookie: string | null

  it('should respond with 204 NO_CONTENT for POST /account/verify-email/', async () => {
    await request(app).post('/account/login').send(loginBody).then((res) => {
      cookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (cookie === null) { throw Error('Failed extracting cookie') }
      return request(app).post('/account/verify-email/').set('Cookie', cookie).send({ code: 123456 })
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
      return request(app).get('/session').set('Cookie', cookie!)
    }).then((response) => {
      expect(response.body.account.isVerified).toBe(true)
    })
  })
})
