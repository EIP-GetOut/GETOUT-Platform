/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { expect, it } from '@jest/globals'
import { StatusCodes } from 'http-status-codes'
import { describe } from 'node:test'
import request, { type Response } from 'supertest'

import { app } from '@config/jestSetup'

import { extractConnectSidCookie } from '../../../setupUtils'

const loginBody = {
  email: 'supertester@test.com',
  password: 'toto'
}

void describe('Logout All Route', async () => {
  it('should respond with 204 NO_CONTENT for POST /account/logout/all', async () => {
    const loginRequests: Array<Promise<Response>> = []
    for (let i = 0; i < 5; i++) {
      loginRequests.push(request(app).post('/account/login').send(loginBody))
    }
    await Promise.all(loginRequests).then(() => {
      return request(app).post('/account/login').send(loginBody)
    }).then((res) => {
      const cookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (cookie === null) { throw Error('Failed extracting cookie') }
      return request(app).post('/account/logout/all').set('Cookie', cookie)
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.NO_CONTENT)
    })
  })
})
