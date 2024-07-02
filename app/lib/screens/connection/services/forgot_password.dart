/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class ForgotPasswordService extends ServiceTemplate {
  final Dio dio;

  ForgotPasswordService(this.dio);

  Future<void> checkEmail(final CheckEmailRequestModel request) async
  {
    try {
      await globals.dio?.post(
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
      await globals.dio?.post(
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