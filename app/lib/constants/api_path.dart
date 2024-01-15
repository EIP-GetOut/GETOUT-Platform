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

  static const String loginPath = '$accountPath/login';
  static const String logoutPath = '$accountPath/logout';
  static const String registerPath = '$accountPath/signup';
  static const String oauthPath = '$accountPath/oauth';
  static const String resetPasswordEmailPath = '$accountPath/reset-password/send-email';
  static const String resetPasswordNewPasswordPath = '$accountPath/reset-password';
  static const String getSessionApiPath = '/session';

  // GENERATE THINGS API PATH

  static const String generateMoviesPath = '/generate-movies';
  static const String getInfoMoviePath = '/movie';

  static const String generateBooksPath = '/generate-books';
  static const String getInfoBookPath = '/book';

  //todo en attendant le getSession, on va mettre ici le token et le cookies en dur qui sera récupérer plus tard avec le getSession
  static const String cookies = 'connect.sid=s%3ABvubf9YeIjX9sZNSMFKSlQX93ZXFziDS.DVpF1Xq%2BSPxyKMAbKfZW1Tc3jQ%2F5fcLSl%2FMtk2Glt6o';
  static const String token = '60eee6af-2ba2-4ff0-ba79-7c6d6c50634f';

}