/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/constants/api_path.dart';

import 'package:getout/global.dart' as globals;

class LoginService {
  Future<void> login(final LoginRequestModel request) async
  {
    try {
      await globals.dio?.post(
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
