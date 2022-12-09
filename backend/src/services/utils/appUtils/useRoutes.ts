/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Application } from 'express'

import basicEndpoints from '@routes/basicEndpoints'
import generateBooks from '@routes/books'
import generateMovies from '@routes/movies'

const useRoutes = (app: Application) => (
  app
    .use(generateMovies)
    .use(generateBooks)
    .use(basicEndpoints)
)

export default useRoutes
