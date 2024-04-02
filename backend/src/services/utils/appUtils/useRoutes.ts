/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import { type Application } from 'express'

import account from '@routes/account'
import changePassword from '@routes/account/changePassword'
import dislikedBooks from '@routes/account/dislikedBooks'
import dislikedMovies from '@routes/account/dislikedMovies'
import likedBooks from '@routes/account/likedBooks'
import likedMovies from '@routes/account/likedMovies'
import login from '@routes/account/login'
import logoutAll from '@routes/account/logout/all'
import logout from '@routes/account/logout/logout'
import oauth from '@routes/account/oauth/oauth'
import preferences from '@routes/account/preferences'
import readBooks from '@routes/account/readBooks'
import readingList from '@routes/account/readingList'
import recommendBooks from '@routes/account/recommendBooks'
import recommendedBooksHistory from '@routes/account/recommendedBooksHistory'
import recommendedMoviesHistory from '@routes/account/recommendedMoviesHistory'
import recommendMovies from '@routes/account/recommendMovies'
import isAllowed from '@routes/account/resetPassword/isAllowed/isAllowed'
import resetPassword from '@routes/account/resetPassword/resetPassword'
import sendEmail from '@routes/account/resetPassword/sendEmail/sendEmail'
import seenMovies from '@routes/account/seenMovies'
import signup from '@routes/account/signup'
import watchlist from '@routes/account/watchlist'
import basicEndpoints from '@routes/basicEndpoints'
import book from '@routes/book'
import movie from '@routes/movie'
import permissions from '@routes/permissions'
import session from '@routes/session'

const useRoutes = (app: Application): Application => (
  app
    .use(recommendBooks)
    .use(recommendMovies)

    .use(recommendedBooksHistory)
    .use(recommendedMoviesHistory)

    .use(watchlist)
    .use(readingList)

    .use(likedMovies)
    .use(likedBooks)

    .use(dislikedBooks)
    .use(dislikedMovies)

    .use(seenMovies)
    .use(readBooks)

    .use(sendEmail)
    .use(resetPassword)
    .use(isAllowed)

    .use(movie)
    .use(book)

    .use(oauth)
    .use(preferences)
    .use(changePassword)
    .use(logoutAll)
    .use(session)
    .use(logout)
    .use(login)
    .use(signup)

    .use(permissions)
    .use(account)
    .use(basicEndpoints)
)

export default useRoutes
