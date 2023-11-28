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

import { extractConnectSidCookie } from '../../utils_funcs'

const loginBody = {
  email: 'supertester@tester.test',
  password: 'toto'
}

describe('Logout Route', async () => {
  it('should respond with 204 NO_CONTENT for POST /account/logout', async () => {
    await request(app).post('/account/login').send(loginBody).then(async (res) => {
      const cookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (cookie === null) { throw Error('Failed extracting cookie') }
      return (await request(app).post('/account/logout').set('Cookie', cookie))
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.NO_CONTENT)
    })
  })
})
