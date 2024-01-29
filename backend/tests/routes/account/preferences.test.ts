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

const loginBody = {
  email: 'supertester@tester.test',
  password: 'toto'
}

describe('Preferences List Route', async () => {
  let cookie: string

  beforeAll(async () => {
    await request(app).post('/account/login').send(loginBody).then(async (res) => {
      const optionalCookie = extractConnectSidCookie(res.headers['set-cookie'][0])
      if (optionalCookie === null) { throw Error('Failed extracting cookie') }
      cookie = optionalCookie
      return await request(app).get('/session').set('Cookie', cookie)
    })
  })

  it('should respond with 201 CREATED and the watchlist for POST /account/preferences', async () => {
    await request(app).post('/account/preferences').send({
      moviesGenres: [70, 60, 50],
      booksGenres: ['Polar', 'Romance', 'Aventure'],
      platforms: ['netflix', 'disney']
    }).set('Cookie', cookie)
      .then((response) => {
        expect(response.status).toBe(StatusCodes.CREATED)
        expect(response.body.moviesGenres).toContain(70)
        expect(response.body.booksGenres).toContain('Polar')
        expect(response.body.platforms).toContain('netflix')
      })
  })

  it('should respond with 200 OK and the watchlist for PUT /account/preferences', async () => {
    await request(app).put('/account/preferences').set('Cookie', cookie).send({
      moviesGenres: [115, 59],
      booksGenres: ['Aventure'],
      platforms: ['PrimeVideo']
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body.moviesGenres).toContain(115)
      expect(response.body.moviesGenres).not.toContain(70)
      expect(response.body.booksGenres).not.toContain('Polar')
      expect(response.body.booksGenres).not.toContain('Romance')
      expect(response.body.platforms).not.toContain('netflix')
      expect(response.body.platforms).toContain('PrimeVideo')
    })
  })
})
