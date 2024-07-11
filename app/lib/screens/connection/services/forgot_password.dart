/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class CheckEmailRequestModel {
  const CheckEmailRequestModel({required this.email});

  final String email;
}

class NewPasswordRequestModel {
  const NewPasswordRequestModel({required this.code, required this.password,  required this.confirmPassword});

  final String code;
  final String password;
  final String confirmPassword;
}

class ForgotPasswordService extends ServiceTemplate {
  final Dio dio;

  ForgotPasswordService(this.dio);

  Future<Response> checkEmail(final CheckEmailRequestModel request) async {
    try {
      return await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.resetPasswordEmailPath}',
          data: {
            'email': request.email,
          });
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> sendNewPassword(final NewPasswordRequestModel request) async {
    try {
      return await dio.post(
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