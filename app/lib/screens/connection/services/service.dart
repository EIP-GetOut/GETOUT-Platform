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

/**
 * login:
 */
import 'package:getout/screens/connection/forgot_password/pages/new_password/bloc/new_password_bloc.dart';
import 'package:getout/screens/connection/forgot_password/pages/check_email/bloc/check_email_bloc.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/connection/email_verified/bloc/email_verified_bloc.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/global.dart' as globals;

/**
 * parts:
 */
part 'sign.dart';
part 'forgot_password.dart';

class ConnectionService extends _ConnectionService<SignService, ForgotPasswordService> {
  ConnectionService() {
    t = SignService();
    g = ForgotPasswordService();
  }
  //Dashboard
  Future<LoginResponseModel> login(LoginRequestModel request) => t.login(request);
  Future<RegisterResponseModel> register(RegisterRequestModel request) => t.register(request);
  Future<CheckEmailResponseModel> checkEmail(CheckEmailRequestModel request) => g.checkEmail(request);
  Future<NewPasswordResponseModel> newPassword(NewPasswordRequestModel request) => g.sendNewPassword(request);
  Future<EmailVerifiedResponseModel> emailVerified(EmailVerifiedRequestModel request) => t.emailVerified(request);
  Future<EmailVerifiedResendResponseModel> emailVerifiedResend() => t.emailVerifiedResend();
}

abstract class ServiceTemplate {}

class _ConnectionService<T, G extends ServiceTemplate> {
  late final T t;
  late final G g;
}