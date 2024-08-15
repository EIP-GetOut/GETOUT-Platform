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
  email: 'recommendBooks@test.com',
  firstName: 'Super',
  lastName: 'Tester',
  bornDate: '07/06/2001',
  password: 'toto'
}

const loginBody = {
  email: 'recommendBooks@test.com',
  password: 'toto'
}

const preferences: Preferences = {
  moviesGenres: [12, 16, 35],
  booksGenres: ['Histoire', 'Roman', 'Suspence'],
  platforms: ['PrimeVideo']
}

void describe('Recommend Books Route', async () => {
  let accountId: UUID
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
        return await request(app).get('/session').set('Cookie', cookie)
      }).then((res) => {
        accountId = res.body.account.id
      })
    })
  })

  it('should respond with 200 OK and the recommended books for GET /account/:accountId/recommendBooks', async () => {
    let recommendedBooks: any[]

    await request(app).post('/account/preferences').send(preferences).set('Cookie', cookie).then(async () => {
      return await request(app).get(`/account/${accountId}/recommend-books`).set('Cookie', cookie)
    }).then(async (response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body).toHaveLength(5)
      recommendedBooks = response.body
      return await request(app).get(`/account/${accountId}/recommend-books`).set('Cookie', cookie)
    }).then((response) => {
      expect(response.status).toBe(StatusCodes.OK)
      expect(response.body[0].kind).toBe(recommendedBooks[0].kind)
      expect(response.body[0].id).toBe(recommendedBooks[0].id)
      expect(response.body[1].kind).toBe(recommendedBooks[1].kind)
      expect(response.body[1].id).toBe(recommendedBooks[1].id)
      expect(response.body[2].kind).toBe(recommendedBooks[2].kind)
      expect(response.body[2].id).toBe(recommendedBooks[2].id)
      expect(response.body[3].kind).toBe(recommendedBooks[3].kind)
      expect(response.body[3].id).toBe(recommendedBooks[3].id)
      expect(response.body[4].kind).toBe(recommendedBooks[4].kind)
      expect(response.body[4].id).toBe(recommendedBooks[4].id)
    })
  }, 15000)
})
