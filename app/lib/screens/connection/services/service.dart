/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';


import 'package:getout/constants/api_path.dart';

/// login
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/screens/connection/forgot_password/children/check_email/bloc/check_email_bloc.dart';

import 'package:getout/global.dart' as globals;

/**
 * parts:
 */
part 'sign.dart';
part 'forgot_password.dart';

class ConnectionService extends _ConnectionService<SignService, ForgotPasswordService> {
  final Dio dio = Dio();

  ConnectionService(String cookiePath) {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
    t = SignService(dio);
    g = ForgotPasswordService(dio);
  }
  //Dashboard
  Future<Response> login(LoginRequestModel request) => t.login(request);
  Future<Response> register(RegisterRequestModel request) => t.register(request);
  Future<void> checkEmail(CheckEmailRequestModel request) => g.checkEmail(request);
  Future<void> newPassword(NewPasswordRequestModel request) => g.sendNewPassword(request);
}

abstract class ServiceTemplate {}

class _ConnectionService<T, G extends ServiceTemplate> {
  late final T t;
  late final G g;
}