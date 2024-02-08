
/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'dart:io';

import 'package:getout/constants/api_path.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:getout/screens/connection/get_session/bloc/get_session_event.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../constants/http_status.dart';
import 'package:getout/global.dart' as globals;

class GetSessionService {
  GetSessionServiceRequest g = GetSessionServiceRequest();
  //Dashboard
  Future<GetSessionStatusResponse> getSession(final GetSessionRequest request) => g.getSession(request);
}

class GetSessionServiceRequest {

  Future<GetSessionStatusResponse> getSession(final GetSessionRequest request) async
  {
      GetSessionStatusResponse result =
        const GetSessionStatusResponse(statusCode: HttpStatus.APP_ERROR);
      final dio = Dio();

      // Directory appDocDir = await getApplicationDocumentsDirectory();
      //   String appDocPath = appDocDir.path;

      // print(appDocPath + "/.cookies/");
  
      // globals.cookieJar = PersistCookieJar(
      //       ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));
      dio.interceptors.add(CookieManager(globals.cookieJar));
      print("avant le load for request");
      final cookies = await globals.cookieJar.loadForRequest(Uri.parse('${ApiConstants.rootApiPath}${ApiConstants.session}'));
      // print("taille");
      // print(globals.dio.interceptors);
      // print("taille fin");
      final response  = await globals.dio.get('${ApiConstants.rootApiPath}${ApiConstants.session}', options: Options(headers: {'Cookie': cookies}));

      print("dans le get session : ");
      // print(globals.dio.options.headers);
      print(response); // should contain session with account

    try {
      if (response.statusCode != GetSessionStatusResponse.success) {
        return GetSessionStatusResponse(statusCode: response.statusCode ?? 500);
      }

      result = GetSessionStatusResponse(
        id: response.data['account']['id'],
        email: response.data['account']['email'],
        firstName: response.data['account']['firstName'],
        lastName: response.data['account']['lastName'],
        bornDate: response.data['account']['bornDate'],
        createDate: response.data['account']['createDate'],
        preferences: response.data['account']['preferences'],
        statusCode: response.statusCode ?? 500,
      );
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const GetSessionStatusResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}