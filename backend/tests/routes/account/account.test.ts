/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { beforeAll, expect, it } from '@jest/globals'
import { StatusCodes } from 'http-status-codes'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

import { extractConnectSidCookie } from '../../setupUtils'

const bodySignup = {
  email: 'account@test.com',
  firstName: 'Super',
  lastName: 'Tester',
  bornDate: '07/06/2001',
  password: 'toto'
}

const loginBody = {
  email: 'account@test.com',
  password: 'toto'
}
const patchBody = {
  firstName: 'Patched',
  lastName: 'User'
}

void describe('Account Routes', () => {
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
      })
    })
  })

  it('should respond with 200 OK for PATCH /account and then 204 NO CONTENT for DELETE /account', async () => {
    await request(app).patch('/account').set('Cookie', cookie).send(patchBody).then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body.firstName).toBe(patchBody.firstName)
      expect(response.body.lastName).toBe(patchBody.lastName)
    })

    await request(app).delete('/account').set('Cookie', cookie).then((response) => {
      expect(response.status).toBe(StatusCodes.NO_CONTENT)
    })
  })
})
