/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class SignService extends ServiceTemplate {
  SignService();

  Future<void> login(final LoginRequestModel request) async {
    if (globals.cookieJar == null || globals.dio == null) {
      return;
    }
    try {
      await globals.dio
          ?.post('${ApiConstants.rootApiPath}${ApiConstants.loginPath}',
              data: {
                'email': request.email,
                'password': request.password,
              },
              options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      print("error : ");
      print(dioError);
      rethrow;
    }
  }

  Future<void> register(final RegisterRequestModel request) async {
    try {
      await globals.dio?.post('${ApiConstants.rootApiPath}${ApiConstants.registerPath}',
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
