/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import 'package:flutter/foundation.dart';

const String rootApiPath = (kDebugMode) ? '10.0.2.2:8080' : 'our.perry.com'; // 10.0.2.2 is the localhost address for android emulator
//const String rootApiPath = /*'192.168.1.13:8080'PERRY*/ '192.168.0.143:8080' /*XO7*/;
// const String rootApiProtocol = (kDebugMode) ? 'http' : 'https';

// ACCOUNT API PATH
const String loginApiPath = '/account/login';
const String logoutApiPath = '/account/logout';
const String signupApiPath = '/account/signup';
const String resetPasswordApiPath = '/account/reset-password'; // <
const String forgetPasswordCodeApiPath = '/account/forget-password-code'; // <
const String forgetPasswordChangeApiPath = '/account/forget-password-change'; // <
const String getSessionApiPath = '/session';
// GENERATE THINGS API PATH
const String generateMoviesApiPath = '/generate-movies';
const String getInfoMovieApiPath = '/movie';
const String generateBooksApiPath = '/generate-books';
// const String getInfoBookApiPath = '/book'; // don't know yet // <