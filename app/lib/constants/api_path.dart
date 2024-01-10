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
const String resetPasswordNewPasswordPath = '/account/reset-password';
const String resetPasswordEmailPath = '/account/reset-password/send-email';
const String getSessionApiPath = '/session';
// GENERATE THINGS API PATH
const String generateMoviesApiPath = '/generate-movies';
const String getInfoMovieApiPath = '/movie';

const String generateBooksApiPath = '/generate-books';
const String getInfoBookApiPath = '/book';

// en attendant le getSession, on va mettre ici le token et le cookies en dur qui sera récupérer plus tard avec le getSession
const String cookies = '';
const String token = '';
