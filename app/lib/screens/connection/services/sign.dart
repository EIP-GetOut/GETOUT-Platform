/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class SignService extends ServiceTemplate {

  final Dio dio = Dio(globals.dioOptions);

  SignService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(globals.cookiePath))));
  }

  Future<LoginResponseModel> login(final LoginRequestModel request) async
  {
    LoginResponseModel response =
        const LoginResponseModel(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response dioResponse =
          await dio.post('${ApiConstants.rootApiPath}${ApiConstants.loginPath}',
              data: {
                'email': request.email,
                'password': request.password,
              });
      response = LoginResponseModel(
          statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return LoginResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return LoginResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return response;
    }
    return response;
  }

  Future<RegisterResponseModel> register(final RegisterRequestModel request) async {
    RegisterResponseModel response =
    const RegisterResponseModel(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response dioResponse =
      await dio.post('${ApiConstants.rootApiPath}${ApiConstants.registerPath}',
          data: {
            'email': request.email,
            'password': request.password,
            'firstName': request.firstName,
            'lastName': request.lastName,
            'bornDate': request.birthDate,
          });
      response = RegisterResponseModel(
          statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return RegisterResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return RegisterResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return response;
    }
    return response;
  }

  Future<EmailVerifiedResponseModel> emailVerified(final EmailVerifiedRequestModel request) async {
    EmailVerifiedResponseModel response =
    const EmailVerifiedResponseModel(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response dioResponse = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.verifyEmailPath}',
          data: {
            'code': int.parse(request.code),
          });
      response = EmailVerifiedResponseModel(
          statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return EmailVerifiedResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return EmailVerifiedResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return response;
    }
    return response;
  }

  Future<EmailVerifiedResendResponseModel> emailVerifiedResend() async {
    EmailVerifiedResendResponseModel response =
    const EmailVerifiedResendResponseModel(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response dioResponse = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.verifyEmailResendPath}');
      response = EmailVerifiedResendResponseModel(
          statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return EmailVerifiedResendResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return EmailVerifiedResendResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return response;
    }
    return response;
  }
}
