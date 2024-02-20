/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/constants/movie_genre.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/global.dart' as globals;

part 'form_model.dart';

class FormServices {

  Future<void> sendPreferences(final FormRequestModel request) async
  {
    if (globals.cookieJar == null || globals.dio == null || globals.session == null) {
      return;
    }
    final Map<String, List<Object>> preferences = {
      'moviesGenres': request.filmGenres,
      'booksGenres': request.literaryGenres,
      'platforms': request.viewingPlatform
    };
    try {
      if (globals.session?['preferences'] == null) {
        await globals.dio?.post(
            '${ApiConstants.rootApiPath}${ApiConstants.preferencesApiPath}',
            data: preferences,
            options: Options(headers: {'Content-Type': 'application/json'}));
      } else {
        await globals.dio?.put(
            '${ApiConstants.rootApiPath}${ApiConstants.preferencesApiPath}',
            data: preferences,
            options: Options(headers: {'Content-Type': 'application/json'}));
      }
    } on DioException {
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }
}