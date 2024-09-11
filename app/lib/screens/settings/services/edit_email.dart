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

part 'edit_email_model.dart';

class EditEmailServices {
  final Dio dio = Dio();

  EditEmailServices() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
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
          // data: preferences,
          options: Options(headers: {'Content-Type': 'application/json'}));
      response = EditEmailResponseModel(statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.response != null && dioException.response?.statusCode != null) {
        response = EditEmailResponseModel(
            statusCode: dioException.response?.statusCode ?? HttpStatus.APP_ERROR);
      }
    } catch (dioError) {
      response = const EditEmailResponseModel(statusCode: HttpStatus.APP_ERROR);
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
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
      response = EmailVerificationResponseModel(statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.response != null && dioException.response?.statusCode != null) {
        response = EmailVerificationResponseModel(
            statusCode: dioException.response?.statusCode ?? HttpStatus.APP_ERROR);
      }
    } catch (error) {
      return response;
    }
    return response;
  }

  Future<void> emailVerifiedResend() async {
    try {
      await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.verifyEmailResendPath}',
          options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}