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
  email: 'supertester@test.com',
  password: 'toto'
}

void describe('Preferences List Route', async () => {
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
      moviesGenres: [12, 16, 35],
      booksGenres: ['Histoire', 'Roman', 'Suspence'],
      platforms: ['netflix', 'disney']
    }).set('Cookie', cookie)
      .then((response) => {
        console.log(response)
        expect(response.status).toBe(StatusCodes.CREATED)
        expect(response.body.moviesGenres).toContain(12)
        expect(response.body.booksGenres).toContain('novel')
        expect(response.body.platforms).toContain('netflix')
      })
  }, 15000)

  it('should respond with 200 OK and the watchlist for PUT /account/preferences', async () => {
    await request(app).put('/account/preferences').set('Cookie', cookie).send({
      moviesGenres: [878, 10770],
      booksGenres: ['Philosophie'],
      platforms: ['PrimeVideo']
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body.moviesGenres).toContain(10770)
      expect(response.body.moviesGenres).not.toContain(12)
      expect(response.body.booksGenres).toContain('philosophy')
      expect(response.body.booksGenres).not.toContain('political')
      expect(response.body.booksGenres).not.toContain('romance')
      expect(response.body.platforms).not.toContain('netflix')
      expect(response.body.platforms).toContain('PrimeVideo')
    })
  }, 15000)

  it('should respond with 201 CREATED and the watchlist for GET /account/preferences', async () => {
    await request(app).get('/account/preferences').set('Cookie', cookie)
      .then((response) => {
        expect(response.status).toBe(StatusCodes.OK)
        expect(response.body.moviesGenres).toContain(878)
        expect(response.body.moviesGenres).toContain(10770)
        expect(response.body.booksGenres).toContain('philosophy')
        expect(response.body.platforms).toContain('PrimeVideo')
      })
  })
})
