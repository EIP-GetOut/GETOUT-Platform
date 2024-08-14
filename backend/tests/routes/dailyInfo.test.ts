/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

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

void describe('Daily Info route', () => {
  it('should respond with 200 OK for GET /daily-info with the daily info', async () => {
    await request(app).get('/daily-info').then((response) => {
      expect(response.status).toBe(200)
      expect(response.body).toHaveProperty('quote')
      expect(response.body).toHaveProperty('author')
      expect(response.body).toHaveProperty('source')
      // eslint-disable-next-line @typescript-eslint/strict-boolean-expressions
      expect(response.body.author && response.body.source).toBeNull()
    })
  })
})
