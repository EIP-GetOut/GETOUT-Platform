/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Application } from 'express'

import changePassword from '@routes/account/changePassword'
import login from '@routes/account/login'
import logout from '@routes/account/logout'
import oauth from '@routes/account/oauth/oauth'
import readingList from '@routes/account/readingList'
import resetPassword from '@routes/account/resetPassword/resetPassword'
import sendEmail from '@routes/account/resetPassword/sendEmail/sendEmail'
import signup from '@routes/account/signup'
import watchlist from '@routes/account/watchlist'
import basicEndpoints from '@routes/basicEndpoints'
import book from '@routes/book'
import generateBooks from '@routes/books'
import movie from '@routes/movie'
import generateMovies from '@routes/movies'
import session from '@routes/session'

const useRoutes = (app: Application): Application => (
  app
    .use(watchlist)
    .use(readingList)
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
    .use(movie)
    .use(book)
    .use(basicEndpoints)
)

export default useRoutes
