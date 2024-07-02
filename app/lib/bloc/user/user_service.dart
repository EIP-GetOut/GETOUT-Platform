/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/
//aa
import 'dart:developer';
//aa
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:getout/bloc/user/user_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/global.dart' as globals;

import '../../tools/status.dart';

class UserService {
  final Dio dio = Dio();

  UserService(String cookiePath) {
        dio.interceptors.add(CookieManager(PersistCookieJar(
                ignoreExpires: true,
                storage: FileStorage(cookiePath))));
  }

  Future<Account?> getSession() async {
    try {
      final response = await globals.dio
          ?.get('${ApiConstants.rootApiPath}${ApiConstants.session}');
      if (response?.statusCode == HttpStatus.OK) {
        if (response?.data['account'] != null) {
          final account = response?.data['account'];
          return Account(
              isVerified: account['isVerified'],
              email: account['email'],
              firstName: account['firstName'],
              lastName: account['lastName'],
              bornDate: account[''],
              createdDate: account[''],
              spentMinutesReadinAndWatching: account['spentMinutesReadingAndWatching'],
              platforms: account['prefrences']['platforms'],
              booksGenres: account['prefrences']['booksGenres'],
              moviesGenres: account['prefrences']['moviesGenres']);
        }
      }
    } on DioException {
      rethrow;
    } catch (dioError) {
      rethrow;
    }
    return null;
  }

  Future<SessionStatusResponse> getSessions() async {
    if (globals.cookieJar == null && globals.dio == null) {
//      await setCookies();
    }
      try {
        final response = await globals.dio
            ?.get('${ApiConstants.rootApiPath}${ApiConstants.session}');
        if (response?.statusCode == HttpStatus.OK) {
          if (response?.data['account'] != null) {
            globals.session = response?.data['account'];
            //isVerified bool,
            //readBooks List<string>,
            //watchlist List<int>,
            //readingList List<String>,
            //likedMovies List<int>,
            //likedBooks List<String>,
            //dislikedMovies List<int>,
            //dislikedBooks List<String>,
            //seenMovies List<int>,
            //lastMovieRecommandation List<int>,
            //lastBookRecommandation List<String>,
            //recommendedBooksHistory List<String>
            //recommendedMoviesHistory List<int>,
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
            //print(response?.headers);
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
