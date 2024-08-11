/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { beforeAll, expect, it } from '@jest/globals'
import { StatusCodes } from 'http-status-codes'
import { type UUID } from 'node:crypto'
import { describe } from 'node:test'
import request from 'supertest'

import { type Preferences } from '@models/account/preferences.interface'

import { app } from '@config/jestSetup'

import { extractConnectSidCookie } from '../../setupUtils'

const bodySignup = {
  email: 'recommendMovies@test.com',
  firstName: 'Super',
  lastName: 'Tester',
  bornDate: '07/06/2001',
  password: 'toto'
}

const loginBody = {
  email: 'recommendMovies@test.com',
  password: 'toto'
}

const preferences: Preferences = {
  moviesGenres: [27, 36],
  booksGenres: ['Politique'],
  platforms: ['PrimeVideo']
}

void describe('Recommend Movies Route', async () => {
  let accountId: UUID
  let cookie: string

  beforeAll(async () => {
    await request(app).post('/account/signup').send(bodySignup).then(async (response) => {
      if (response.statusCode !== StatusCodes.CREATED) {
        throw Error(`Failed creating account: ${response.statusCode}`)
      }
      await request(app).post('/account/login').send(loginBody).then(async (res) => {
        const optionalCookie = extractConnectSidCookie(res.headers['set-cookie'][0])
        if (optionalCookie === null) { throw Error('Failed extracting cookie') }
        cookie = optionalCookie
        return await request(app).get('/session').set('Cookie', cookie)
      }).then((res) => {
        accountId = res.body.account.id
      })
    })
  })

  it('should respond with 200 OK and the recommended movies for GET /account/:accountId/recommendMovies', async () => {
    let recommendedMovies: any[]

    await request(app).post('/account/preferences').send(preferences).set('Cookie', cookie).then(async () => {
      return await request(app).get(`/account/${accountId}/recommend-movies`).set('Cookie', cookie)
    }).then(async (response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body).toHaveLength(5)
      recommendedMovies = response.body
      return await request(app).get(`/account/${accountId}/recommend-movies`).set('Cookie', cookie)
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body).toStrictEqual(recommendedMovies)
    })
  }, 10000)
})