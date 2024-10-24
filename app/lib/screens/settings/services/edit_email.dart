/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/global.dart' as globals;

part 'edit_email_model.dart';

class EditEmailServices {
  final Dio dio = Dio(globals.dioOptions);

  EditEmailServices() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
  }

  Future<EditEmailResponseModel> sendNewEmail(final EditEmailRequestModel request) async
  {
    EditEmailResponseModel response = const EditEmailResponseModel(statusCode: HttpStatus.APP_ERROR);

    if (globals.session == null) {
      return response;
    }
    try {
      Response dioResponse = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.changeEmailPath}',
      );
      response = EditEmailResponseModel(statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return EditEmailResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return EditEmailResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (dioError) {
      return response;
    }
    return response;
  }

  Future<EmailVerificationResponseModel> emailVerified(final EmailVerificationRequestModel request) async {

    EmailVerificationResponseModel response = const EmailVerificationResponseModel(statusCode: HttpStatus.APP_ERROR);

    try {
      Response dioResponse = await dio
          .post('${ApiConstants.rootApiPath}${ApiConstants.verifyEmailPath}',
          data: {
            'code': int.parse(request.code),
          });
      response = EmailVerificationResponseModel(statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return EmailVerificationResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return EmailVerificationResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return response;
    }
    return response;
  }
}