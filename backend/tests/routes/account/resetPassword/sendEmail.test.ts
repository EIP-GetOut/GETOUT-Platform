/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { expect, it } from '@jest/globals'
import { StatusCodes } from 'http-status-codes'
import { describe } from 'node:test'
import request from 'supertest'

import { app } from '@config/jestSetup'

// const bodySignup = {
//   email: 'john-doe@trash-mail.com',
//   firstName: 'John',
//   lastName: 'Doe',
//   bornDate: '07/06/2001',
//   password: 'toto'
// }

// const loginBody = {
//   email: 'john-doe@trash-mail.com',
//   password: 'toto'
// }

void describe('Reset password send email route', async () => {
  it('should respond with 200 OK for POST /account/reset-password/send-email', async () => {
    await request(app).post('/account/reset-password/send-email').send({
      email: 'supertester@test.com'
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
    })
  })
})
