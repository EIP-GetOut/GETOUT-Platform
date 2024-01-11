/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import 'package:flutter/foundation.dart';

const String rootApiPath = (kDebugMode)
    ? 'http://10.0.2.2:8080'
    : 'https://api.eip-getout.me';

// ACCOUNT API PATH
const String loginPath = '/account/login';
const String logoutPath = '/account/logout';
const String registerPath = '/account/signup';
const String oauthPath = '/account/oauth';
const String resetPasswordEmailPath = '/account/reset-password/send-email';
const String resetPasswordNewPasswordPath = '/account/reset-password';
const String getSessionApiPath = '/session';
// GENERATE THINGS API PATH
const String generateMoviesApiPath = '/generate-movies';
const String generateBooksApiPath = '/generate-books';
//GET OBJECTS
const String getInfoMovieApiPath = '/movie';
const String getInfoBookApiPath = '/book';

//GET YOUR BOOKS
const String getWishlistBooksApiPath = '/get-wishlist-books';
const String getLikeBooksApiPath = '/get-like-books';
const String getViewBooksApiPath = '/get-view-books';
