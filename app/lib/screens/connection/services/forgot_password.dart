/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class ForgotPasswordService extends ServiceTemplate {
  ForgotPasswordService();

  Future<void> checkEmail(final CheckEmailRequestModel request) async
  {
    try {
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.resetPasswordEmailPath}',
          data: {
            'email': request.email,
            // 'firstName': 'Louis',
            // 'lastName': 'Primas'
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
          print("status =");
          print(response?.statusCode);
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> sendNewPassword(final NewPasswordRequestModel request) async
  {
    try {
      print("in send new password");
      print(request.code);
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.resetPasswordNewPasswordPath}',
          data: {
            'newPassword' : request.password,
            'code': int.parse(request.code)
            // ,
            // 'password' : 'Charles',
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
          print("response = ");
          print(response?.statusCode);
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}