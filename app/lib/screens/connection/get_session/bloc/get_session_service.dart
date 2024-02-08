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
  Future<GetSessionStatusResponse> getSession(
          final GetSessionRequest request) =>
      g.getSession(request);
}

class GetSessionServiceRequest {
  Future<GetSessionStatusResponse> getSession(
      final GetSessionRequest request) async {
    GetSessionStatusResponse result =
        const GetSessionStatusResponse(statusCode: HttpStatus.APP_ERROR);

    if (globals.cookieJar == null && globals.dio == null) {
      print('initializing globals for dio and cookies !');
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      // setup cookie jar
      print('$appDocPath/.cookies/');
      globals.cookieJar = PersistCookieJar(
          ignoreExpires: true, storage: FileStorage('$appDocPath/.cookies/'));
      // setup dio with cookie jar
      globals.dio = Dio();
      globals.dio?.interceptors.add(CookieManager(globals.cookieJar!));
      return result;
    }

    // INIT CURRENT ACCOUNT :
    /*
    read from storage:
    global = storage
    */
    // SessionService.loadSession()
    // LOAD SESSION FROM PERSISTENT STORAGE
    // String? session.account  null | {email: ""}
    // IF SESSION FOUND IN PERSISTENT STORAGE
    // LOAD FOUND ACCOUNT IN globlals.currentAccount
    // REDIRECT TO DASHBOARD (knowing that dev can access globals.currentAccount.firstName ...)
    // IF SESSION NOT FOUND (currentAccount == null) IN PERSISTENT STORAGE
    // REDIRECT TO LOGIN PAGE => COMPUTE LOGIN
    // IF LOGIN SUCCESS => GET SESSION => STORE RESULT session.account IN PERSISTENT STORAGE
    // !!!!!!!!!!!!!!! dans le main
    // fonction reload() => calll get /session dans le back et sync la response avec global + storage (si session.account existe pas supprimer dans le storage et mettre la globale à null)
    // puis dans le main après avoir call le reload et attendu la réponse => on à accès à global.currentAccount et on sait si il est connecté ou non (cf rdirect vers dashboard ou login page)
    // !!!!!!!!!!!!
    // setCurrentAccount() if change firstName .then() -> computeGetSession.then((session) => setCurrentgAccount(session.account))
    print('globals are already initialized');
    final response = await globals.dio
        ?.get('${ApiConstants.rootApiPath}${ApiConstants.session}');
    if (response == null) {
      return result;
    }
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
        return const GetSessionStatusResponse(
            statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}
