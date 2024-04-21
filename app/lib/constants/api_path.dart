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

  /*static const String rootApiPath = (kDebugMode)
      ? 'http://127.0.0.1:8080'
      : 'https://api.eip-getout.me';*/

  // ACCOUNT API PATH
  static const String loginPath = '/account/login';
  static const String logoutPath = '/account/logout';
  static const String registerPath = '/account/signup';
  static const String accountPath = '/account';

  static const String resetPasswordEmailPath = '/account/reset-password/send-email';
  static const String resetPasswordNewPasswordPath = '/account/reset-password';

  static const String preferencesApiPath = '/account/preferences';

  // GENERATE THINGS API PATH
  static const String recommendedMoviesPath = '/recommend-movies';
  static const String getInfoMoviePath = '/movie';

  static const String recommendedBooksPath = '/recommend-books';
  static const String getInfoBookPath = '/book';

  static const String session = '/session';

  static const String addLikedMoviePath = '/likedMovies';
  static const String addDislikedMoviePath = '/dislikedMovies';
  static const String watchlistPath = '/watchlist';
  static const String seenMoviesPath = '/seenMovies';

  static const String addLikedBookPath = '/likedBooks';
  static const String addDislikedBookPath = '/dislikedBooks';
  static const String readingPath = '/readingList';
  static const String readBooksPath = '/readBooks';
}