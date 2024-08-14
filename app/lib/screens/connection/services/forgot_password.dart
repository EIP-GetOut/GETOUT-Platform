/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class ForgotPasswordService extends ServiceTemplate {
  final Dio dio = Dio();

  ForgotPasswordService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
  }

  Future<void> checkEmail(final CheckEmailRequestModel request) async
  {
    try {
      await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.resetPasswordEmailPath}',
          data: {
            'email': request.email,
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> sendNewPassword(final NewPasswordRequestModel request) async
  {
    try {
      await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.resetPasswordNewPasswordPath}',
          data: {
            'newPassword' : request.password,
            'code': int.parse(request.code)
            // ,
            // 'password' : 'Charles',
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}