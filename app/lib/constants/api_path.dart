/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import 'package:flutter/foundation.dart';

class ApiConstants {
  const ApiConstants();

  static const String rootApiPath = (kDebugMode)
    ? 'http://10.0.2.2:8080'
    : 'https://api.eip-getout.me';

  // ACCOUNT API PATH
  static const String accountPath = '/account';

  static const String loginPath = '/account/login';
  static const String logoutPath = '/account/logout';
  static const String registerPath = '/account/signup';
  static const String oauthPath = '/account/oauth';
  static const String resetPasswordEmailPath = '/account/reset-password/send-email';
  static const String resetPasswordNewPasswordPath = '/account/reset-password';
  static const String getSessionApiPath = '/session';

  // GENERATE THINGS API PATH
  static const String generateMoviesPath = '/generate-movies';
  static const String getInfoMoviePath = '/movie';

  static const String generateBooksPath = '/generate-books';
  static const String getInfoBookPath = '/book';

  //todo en attendant le getSession, on va mettre ici le token et le cookies en dur qui sera récupérer plus tard avec le getSession
  static const String cookies = '';
  static const String token = '';

  static const String session = '/session';

}