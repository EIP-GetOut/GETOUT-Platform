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

// describe('Logout Route', () => {
//   it('should respond with 200 OK for POST /account/logout', async () => {
//     await request(app).post('/account/logout').then((response) => {
//       expect(response.status).toBe(200)
//       expect(response.text).toBe('OK')
//     })
//   })
// })
