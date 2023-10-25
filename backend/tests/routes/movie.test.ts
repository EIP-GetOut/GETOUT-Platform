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

describe('Movie Detail Routes', () => {
  it('should respond with 200 OK for GET /movie/951491', async () => {
    await request(app).get('/movie/951491').then((response) => {
      expect(response.status).toBe(200)
      // eslint-disable-next-line no-useless-escape
      expect(response.text).toBe('{\"movie\":{\"title\":\"Saw X\",\"overview\":\"Between the events of \'Saw\' and \'Saw II\', a sick and desperate John Kramer travels to Mexico for a risky and experimental medical procedure in hopes of a miracle cure for his cancer, only to discover the entire operation is a scam to defraud the most vulnerable. Armed with a newfound purpose, the infamous serial killer returns to his work, turning the tables on the con artists in his signature visceral way through devious, deranged, and ingenious traps.\",\"poster_path\":\"/aQPeznSu7XDTrrdCtT5eLiu52Yu.jpg\",\"backdrop_path\":\"/dZbLqRjjiiNCpTYzhzL2NMvz4J0.jpg\",\"release_date\":\"2023-09-26\",\"vote_average\":3.6745,\"duration\":\"1h58\"}}')
    })
  })

  it('should respond with 500 for invalid route', async () => {
    await request(app).get('/movie/nonexistent').then((response) => {
      expect(response.status).toBe(500)
    })
  })
})
