/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/constants/api_path.dart';

class LoginService {
  Future<void> login(final LoginRequestModel request) async
  {
    try {
      final dio = Dio();

      await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.loginPath}',
          data: {
            'email': request.email,
            'password': request.password,
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}

// class SessionService {
//   // void session() async
//   // {
//   //   try {
//   //     final dio = Dio();
//   //     final cookieJar = CookieJar();
//   //     dio.interceptors.add(CookieManager(cookieJar));

//   //     print(await cookieJar.loadForRequest(Uri.parse('http://10.0.2.2:8080/session')));
//   //     // Another request with the cookie.
//   //     final response  = await dio.get("http://10.0.2.2:8080/session");
//   //     print(response); // should contain session with account
//   //   } on DioException { // add "catch (dioError)" for debugging
//   //     rethrow;
//   //   } catch (error) {
//   //     rethrow;
//   //   }
//   // }
// }