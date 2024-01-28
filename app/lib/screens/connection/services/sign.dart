/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class SignService extends ServiceTemplate {
  SignService({required this.dio});

  final Dio dio;

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
    } catch (error) {
      rethrow;
    }
  }

  Future<void> register(final RegisterRequestModel request) async {
    try {
      final dio = Dio();
      await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.registerPath}',
          data: {
            'email': request.email,
            'password': request.password,
            'firstName': request.firstName,
            'lastName': request.lastName,
            'bornDate': request.bornDate,
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
