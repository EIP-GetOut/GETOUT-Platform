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

describe('Movies Routes', () => {
  it('should respond with 200 OK for GET /generate-movies?with_genres=27', async () => {
    await request(app).get('/generate-movies?with_genres=27').then((response) => {
      expect(response.status).toBe(200)
      // eslint-disable-next-line no-useless-escape
      expect(response.text).toBe('{\"movies\":[{\"title\":\"Saw X\",\"poster\":\"/aQPeznSu7XDTrrdCtT5eLiu52Yu.jpg\",\"id\":951491,\"overview\":\"Between the events of \'Saw\' and \'Saw II\', a sick and desperate John Kramer travels to Mexico for a risky and experimental medical procedure in hopes of a miracle cure for his cancer, only to discover the entire operation is a scam to defraud the most vulnerable. Armed with a newfound purpose, the infamous serial killer returns to his work, turning the tables on the con artists in his signature visceral way through devious, deranged, and ingenious traps.\"},{\"title\":\"The Nun II\",\"poster\":\"/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg\",\"id\":968051,\"overview\":\"In 1956 France, a priest is violently murdered, and Sister Irene begins to investigate. She once again comes face-to-face with a powerful evil.\"},{\"title\":\"Meg 2: The Trench\",\"poster\":\"/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg\",\"id\":615656,\"overview\":\"An exploratory dive into the deepest depths of the ocean of a daring research team spirals into chaos when a malevolent mining operation threatens their mission and forces them into a high-stakes battle for survival.\"},{\"title\":\"Five Nights at Freddy\'s\",\"poster\":\"/A4j8S6moJS2zNtRR8oWF08gRnL5.jpg\",\"id\":507089,\"overview\":\"Recently fired and desperate for work, a troubled young man named Mike agrees to take a position as a night security guard at an abandoned theme restaurant: Freddy Fazbear\'s Pizzeria. But he soon discovers that nothing at Freddy\'s is what it seems.\"},{\"title\":\"The Exorcist: Believer\",\"poster\":\"/qVKirUdmoex8SdfUk8WDDWwrcCh.jpg\",\"id\":807172,\"overview\":\"When his daughter and her friend show signs of demonic possession, it unleashes a chain of events that forces single father, Victor Fielding, to confront the nadir of evil. Terrified and desperate, he seeks out the only person alive who\'s witnessed anything like it before.\"}]}')
    })
  })
})
