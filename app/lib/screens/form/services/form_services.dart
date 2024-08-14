/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:getout/constants/genre_list.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/global.dart' as globals;

part 'form_model.dart';

class FormServices {
  final Dio dio = Dio();
  FormServices() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
  }

  Future<FormResponseModel> sendPreferences(final FormRequestModel request) async
  {
    FormResponseModel response = const FormResponseModel(statusCode: HttpStatus.APP_ERROR);
    final Map<String, List<Object>> preferences = {
      'moviesGenres': request.movieGenres,
      'booksGenres': request.bookGenres,
      'platforms': request.viewingPlatform
    };
    dynamic dioResponse; // dynamic because dio can return a DioError or a Response

    if (globals.session == null) {
      return response;
    }
    try {
      if (globals.session?['preferences'] == null) {
        dioResponse = await dio.post(
            '${ApiConstants.rootApiPath}${ApiConstants.preferencesApiPath}',
            data: preferences,
            options: Options(headers: {'Content-Type': 'application/json'}));
      } else {
        dioResponse = await dio.put(
            '${ApiConstants.rootApiPath}${ApiConstants.preferencesApiPath}',
            data: preferences,
            options: Options(headers: {'Content-Type': 'application/json'}));
      }
      if (dioResponse == HttpStatus.OK || dioResponse == HttpStatus.CREATED) {
        globals.session?['preferences'] = preferences;
      }
      response = FormResponseModel(statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.response != null && dioException.response?.statusCode != null) {
        response = FormResponseModel(
            statusCode: dioException.response?.statusCode ?? HttpStatus.APP_ERROR);
      }
    } catch (dioError) {
      response = const FormResponseModel(statusCode: HttpStatus.APP_ERROR);
    }
    return response;
  }
}