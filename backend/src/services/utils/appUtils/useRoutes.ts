/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Application } from 'express'

import changePassword from '@routes/account/changePassword'
import dislikedBooks from '@routes/account/dislikedBooks'
import dislikedMovies from '@routes/account/dislikedMovies'
import likedBooks from '@routes/account/likedBooks'
import likedMovies from '@routes/account/likedMovies'
import login from '@routes/account/login'
import logout from '@routes/account/logout'
import oauth from '@routes/account/oauth/oauth'
import preferences from '@routes/account/preferences'
import readingList from '@routes/account/readingList'
import generateBooks from '@routes/account/recommendBooks'
import generateMovies from '@routes/account/recommendMovies'
import resetPassword from '@routes/account/resetPassword/resetPassword'
import sendEmail from '@routes/account/resetPassword/sendEmail/sendEmail'
import signup from '@routes/account/signup'
import watchlist from '@routes/account/watchlist'
import basicEndpoints from '@routes/basicEndpoints'
import book from '@routes/book'
import movie from '@routes/movie'
import session from '@routes/session'

const useRoutes = (app: Application): Application => (
  app
    .use(generateMovies)
    .use(generateBooks)
    .use(watchlist)
    .use(likedMovies)
    .use(dislikedMovies)
    .use(readingList)
    .use(likedBooks)
    .use(dislikedBooks)
    .use(sendEmail)
    .use(login)
    .use(logout)
    .use(oauth)
    .use(session)
    .use(preferences)
    .use(signup)
    .use(changePassword)
    .use(resetPassword)
    .use(movie)
    .use(book)
    .use(basicEndpoints)
)

export default useRoutes
