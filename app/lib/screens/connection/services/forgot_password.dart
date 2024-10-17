/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class ForgotPasswordService extends ServiceTemplate {
  final Dio dio = Dio(globals.dioOptions);

  ForgotPasswordService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
  }

  Future<CheckEmailResponseModel> checkEmail(final CheckEmailRequestModel request) async
  {
    CheckEmailResponseModel response =
    const CheckEmailResponseModel(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response dioResponse = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.resetPasswordEmailPath}',
          data: {
            'email': request.email,
          });
      response = CheckEmailResponseModel(
          statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return CheckEmailResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return CheckEmailResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return response;
    }
    return response;
  }

  Future<NewPasswordResponseModel> sendNewPassword(final NewPasswordRequestModel request) async
  {
    NewPasswordResponseModel response =
    const NewPasswordResponseModel(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response dioResponse = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.resetPasswordNewPasswordPath}',
          data: {
            'newPassword' : request.password,
            'code': int.parse(request.code)
          });
      response = NewPasswordResponseModel(
          statusCode: dioResponse.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return NewPasswordResponseModel(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return response;
      } else {
        return NewPasswordResponseModel(
            statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return response;
    }
    return response;
  }
}