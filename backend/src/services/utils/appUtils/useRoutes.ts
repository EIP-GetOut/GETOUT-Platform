/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Application } from 'express'

import changePassword from '@routes/account/changePassword/changePassword'
import login from '@routes/account/login/login'
import logout from '@routes/account/logout/logout'
import oauth from '@routes/account/oauth/oauth'
import resetPassword from '@routes/account/resetPassword/resetPassword'
import sendEmail from '@routes/account/resetPassword/sendEmail/sendEmail'
import signup from '@routes/account/signup/signup'
import basicEndpoints from '@routes/basicEndpoints'
import getBook from '@routes/book'
import generateBooks from '@routes/books'
import getMovie from '@routes/movie'
import generateMovies from '@routes/movies'
import session from '@routes/session'

const useRoutes = (app: Application): Application => (
  app
    .use(sendEmail)
    .use(login)
    .use(logout)
    .use(oauth)
    .use(session)
    .use(signup)
    .use(changePassword)
    .use(resetPassword)
    .use(generateMovies)
    .use(generateBooks)
    .use(getMovie)
    .use(getBook)
    .use(basicEndpoints)
)

export default useRoutes
