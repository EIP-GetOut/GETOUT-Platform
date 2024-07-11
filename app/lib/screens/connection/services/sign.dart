/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

///Models
class LoginRequestModel {
  const LoginRequestModel({required this.email, required this.password});

  final String email;
  final String password;
}

class RegisterRequestModel {
  const RegisterRequestModel({required this.email, required this.password, required this.firstName, required this.lastName, required this.birthDate});

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String birthDate;
}

///Services
class SignService extends ServiceTemplate {
  final Dio dio;

  SignService(this.dio);

  Future<Response> login(LoginRequestModel request) async {
    try {
      return await dio.post('${ApiConstants.rootApiPath}${ApiConstants.loginPath}',
              data: {
                'email': request.email,
                'password': request.password,
              }
              );
    } on DioException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> register(final RegisterRequestModel request) async {
    try {
      return await dio.post('${ApiConstants.rootApiPath}${ApiConstants.registerPath}',
          data: {
            'email': request.email,
            'password': request.password,
            'firstName': request.firstName,
            'lastName': request.lastName,
            'bornDate': request.birthDate,
            'salt': 'sdjqshjodijaoz'
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
