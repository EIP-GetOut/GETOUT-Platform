/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class ForgotPasswordService extends ServiceTemplate {
  ForgotPasswordService({required this.dio});

  final Dio dio;

  Future<void> checkEmail(final CheckEmailRequestModel request) async
  {
    try {
      await dio.post(
          '${api_constants.rootApiPath}${api_constants.resetPasswordEmailPath}',
          data: {
            'email': request.email,
            'firstName': 'Louis',
            'lastName': 'Primas'
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
          '${api_constants.rootApiPath}${api_constants.resetPasswordNewPasswordPath}',
          data: {
            'newPassword' : request.password,
            'token': request.code,
            'password' : 'Charles',
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}