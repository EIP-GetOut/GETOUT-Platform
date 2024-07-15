/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:getout/constants/movie_genre.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart';

part 'form_model.dart';

class FormService {
  final Dio dio = Dio();

  FormService(String cookiePath) {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
  }

  Future<Response> sendPreferences(final FormRequestModel request, {bool isFirstTime = false}) async {
    final Map<String, dynamic> preferences = {
      'moviesGenres': request.movieGenres,
      'booksGenres': request.bookGenres,
      'platforms': request.platforms
    };

    try {
      return await (isFirstTime ? dio.post : dio.put)(
            '${ApiConstants.rootApiPath}${ApiConstants.preferencesApiPath}',
            data: preferences
        );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}