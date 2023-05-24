/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { Application } from 'express'

import login from '@routes/account/login/login'
import logout from '@routes/account/logout/logout'
import signup from '@routes/account/signup/signup'
import basicEndpoints from '@routes/basicEndpoints'
import getBook from '@routes/book'
import generateBooks from '@routes/books'
import getMovie from '@routes/movie'
import generateMovies from '@routes/movies'
import session from '@routes/session/session'

const useRoutes = (app: Application) => (
  app
    .use(login)
    .use(logout)
    .use(session)
    .use(signup)
    .use(generateMovies)
    .use(generateBooks)
    .use(getMovie)
    .use(getBook)
    .use(basicEndpoints)
)

export default useRoutes
