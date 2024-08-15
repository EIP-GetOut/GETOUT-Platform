/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/global.dart' as globals;

part 'edit_password_model.dart';

class EditPasswordServices {

  Future<EditPasswordResponseModel> sendNewPassword(final EditPasswordRequestModel request) async
  {
    EditPasswordResponseModel response = const EditPasswordResponseModel(statusCode: HttpStatus.APP_ERROR);
    dynamic dioResponse; // dynamic because dio can return a DioError or a Response

    if (globals.cookieJar == null || globals.dio == null || globals.session == null) {
      return response;
    }
    try {
      dioResponse = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.changePasswordPath}',
          data: {
            'password': request.oldPassword,
            'newPassword': request.newPassword
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
      response = EditPasswordResponseModel(statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.response != null && dioException.response?.statusCode != null) {
        response = EditPasswordResponseModel(
            statusCode: dioException.response?.statusCode ?? HttpStatus.APP_ERROR);
      }
    } catch (dioError) {
      response = const EditPasswordResponseModel(statusCode: HttpStatus.APP_ERROR);
    }
    return response;
  }
}