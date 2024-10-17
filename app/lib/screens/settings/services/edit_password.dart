/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/global.dart' as globals;

part 'edit_password_model.dart';

class EditPasswordServices {

  final Dio dio = Dio(globals.dioOptions);

  EditPasswordServices() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
  }

  Future<EditPasswordResponseModel> sendNewPassword(final EditPasswordRequestModel request) async
  {
    EditPasswordResponseModel response = const EditPasswordResponseModel(statusCode: HttpStatus.APP_ERROR);

    if (globals.session == null) {
      return response;
    }
    try {
      Response dioResponse = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.changePasswordPath}',
          data: {
            'password': request.oldPassword,
            'newPassword': request.newPassword
          },
      );
      response = EditPasswordResponseModel(statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return EditPasswordResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return EditPasswordResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (dioError) {
      return response;
    }
    return response;
  }
}
