/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:getout/constants/api_path.dart' as api;

class ForgotPasswordService {
  Future<void> sendEmail(final ForgotPasswordRequestModel request) async
  {
    try {
      final dio = Dio();
      await dio.post(
          '${api.rootApiPath}${api.forgetPasswordChangePath}',
          data: {
            'email': request.email,
            'firstName' : 'null',
            'lastName' : 'null',
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}