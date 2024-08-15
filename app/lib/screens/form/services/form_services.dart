/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/constants/genre_list.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/global.dart' as globals;

part 'form_model.dart';

class FormServices {

  Future<FormResponseModel> sendPreferences(final FormRequestModel request) async
  {
    FormResponseModel response = const FormResponseModel(statusCode: HttpStatus.APP_ERROR);
    final Map<String, List<Object>> preferences = {
      'moviesGenres': request.movieGenres,
      'booksGenres': request.bookGenres,
      'platforms': request.viewingPlatform
    };
    dynamic dioResponse; // dynamic because dio can return a DioError or a Response

    if (globals.cookieJar == null || globals.dio == null || globals.session == null) {
      return response;
    }
    try {
      if (globals.session?['preferences'] == null) {
        dioResponse = await globals.dio?.post(
            '${ApiConstants.rootApiPath}${ApiConstants.preferencesApiPath}',
            data: preferences,
            options: Options(headers: {'Content-Type': 'application/json'}));
      } else {
        dioResponse = await globals.dio?.put(
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