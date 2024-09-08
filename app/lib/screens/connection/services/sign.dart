/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class SignService extends ServiceTemplate {
  final Dio dio = Dio();
  SignService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
  }

  Future<void> login(final LoginRequestModel request) async {
    try {
      await dio.post('${ApiConstants.rootApiPath}${ApiConstants.loginPath}',
              data: {
                'email': request.email,
                'password': request.password,
              },
              options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      //todo
      if (kDebugMode) {
        print(dioError);
      }
      rethrow;
    }
  }

  Future<void> register(final RegisterRequestModel request) async {
    try {
      await dio
          .post('${ApiConstants.rootApiPath}${ApiConstants.registerPath}',
              data: {
                'email': request.email,
                'password': request.password,
                'firstName': request.firstName,
                'lastName': request.lastName,
                'bornDate': request.birthDate,
              },
              options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> emailVerified(final EmailVerifiedRequestModel request) async {
    try {
      await dio
          .post('${ApiConstants.rootApiPath}${ApiConstants.verifyEmailPath}',
              data: {
                'code': int.parse(request.code),
              },
              options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
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
