/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { expect, it } from '@jest/globals'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

const loginBody = {
  email: 'supertester@test.com',
  password: 'toto'
}

void describe('Login Routes', () => {
  it('should respond with 200 OK for POST /account/login', async () => {
    await request(app).post('/account/login').send(loginBody).then((response) => {
      expect(response.status).toBe(200)
    })
  })
})
