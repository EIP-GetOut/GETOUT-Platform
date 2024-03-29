/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/constants/api_path.dart';

class RegisterService {
  Future<void> register(final RegisterRequestModel request) async
  {
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
    } on DioException { // add "catch (dioError)" for debugging
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
