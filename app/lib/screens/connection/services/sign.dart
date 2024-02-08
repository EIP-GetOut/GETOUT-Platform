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
      // print("ICI CA LOGIN DANS CETTE FONCTION");
      globals.dio.interceptors.add(CookieManager(globals.cookieJar));
      await globals.dio.post('${ApiConstants.rootApiPath}${ApiConstants.loginPath}',
          data: {
            'email': request.email,
            'password': request.password,
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
      print(await globals.cookieJar.loadForRequest(Uri.parse('http://10.0.2.2:8080/session')));
      final response  = await globals.dio.get("http://10.0.2.2:8080/session");
      print("EHOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      print(globals.dio.options.headers);
      print(response); // should contain session with account
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
