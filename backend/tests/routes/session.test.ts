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

describe('Session route', () => {
  it('should respond with 200 OK for GET /session', async () => {
    await request(app).get('/session').then((response) => {
      expect(response.status).toBe(200)
      expect(response.body).toHaveProperty('cookie')
    })
  })
})
