/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Julien Letoux <julien.letoux@epitech.eu>
*/

import { expect, it } from '@jest/globals'
import { describe } from 'node:test'
import request from 'supertest'

import logger from '@services/middlewares/logging'

import { app } from '@config/jestSetup'

const bodySignup = {
  email: 'julien.letoux@epitech.eu',
  firstName: 'Julien',
  lastName: 'Letoux',
  bornDate: '07/06/2001',
  password: 'toto'
}

const body = {
  email: 'julien.letoux@epitech.eu',
  password: 'toto'
}

describe('Login Routes', () => {
  it('should respond with 200 OK for POST /account/login', async () => {
    await request(app).post('/account/signup').send(bodySignup).then((res) => {
      request(app).post('/account/login').send(body).then((response) => {
        expect(response.status).toBe(200)
        expect(response.text).toBe('OK')
      }).catch((err) => {
        console.log(err)
      })
    })
  })

  it('should respond with 200 OK for POST /account/login', async () => {
    await request(app).post('/account/login').then((response) => {
      expect(response.status).toBe(404)
    }).catch((err) => {
      console.log(err)
    })
  })
})
