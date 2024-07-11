/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/
//aa
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/global.dart' as globals;

class SessionService {
  Future<void> setCookies() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    globals.cookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage('$appDocPath/.cookies/'));

    globals.dio = Dio();
    globals.dio?.interceptors.add(CookieManager(globals.cookieJar!));
  }

  Future<SessionStatusResponse> getSession() async {
    if (globals.cookieJar == null && globals.dio == null) {
      await setCookies();
    }
      try {
        final response = await globals.dio
            ?.get('${ApiConstants.rootApiPath}${ApiConstants.session}');
        if (response?.statusCode == HttpStatus.OK) {
          if (response?.data['account'] != null) {
            globals.session = response?.data['account'];
            //isVerified bool,
            //readBooks List<string>, //todo remove
            //watchlist List<int>, //todo remove
            //readingList List<String>, //todo remove
            //likedMovies List<int>, //todo remove
            //likedBooks List<String>, //todo remove
            //dislikedMovies List<int>, //todo remove
            //dislikedBooks List<String>, //todo remove
            //seenMovies List<int>,  //todo remove
            //lastMovieRecommandation List<int>, //todo remove
            //lastBookRecommandation List<String>, //todo remove
            //recommendedBooksHistory List<String> //todo remove
            //recommendedMoviesHistory List<int>, //todo remove
            //id String,
            //email String,
            //firstName String,
            //lastName String,
            //bornDate String,
            //createdDate String,
            //modifiedDate,
            //spentMinutesReadingAndWatching int,
            //preferences Object:
            //    platforms List<String>
            //    booksGenres -> List<int>
            //    moviesGenres -> List<String>

            //print(response?.data['account'].toString().substring(000));
            print(response?.headers);
            if (response?.data['account']['preferences'] != null) {
              return SessionStatusResponse(
                  statusCode: SessionStatus.found.index);
            } else {
              return SessionStatusResponse(
                  statusCode: SessionStatus.foundWithoutPreferences.index);
            }
          } else {
            globals.session = null;
            return SessionStatusResponse(
                statusCode: SessionStatus.notFound.index);
          }
        }
      } on DioException {
        // add "catch (dioError)" for debugging
        rethrow;
      } catch (dioError) {
        rethrow;
      }
    return SessionStatusResponse(statusCode: SessionStatus.error.index);
  }
}
