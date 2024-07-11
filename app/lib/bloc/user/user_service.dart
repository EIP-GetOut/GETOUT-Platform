/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:getout/bloc/user/user_bloc.dart';

import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/global.dart' as globals;

class UserService {
  final Dio dio = Dio();

  UserService(String cookiePath) {
        dio.interceptors.add(CookieManager(PersistCookieJar(
                ignoreExpires: true,
                storage: FileStorage(cookiePath))));
  }

  Future<Account?> getSession() async {
    try {
      final response = await dio.get('${ApiConstants.rootApiPath}${ApiConstants.session}');
      if (response.statusCode == HttpStatus.OK) {
        if (response.data['account'] != null) {
          final account = response.data['account'];
          final preferences = account['preferences'];
          print('0.1');
          Account acc = Account(
              isVerified: account['isVerified'],
              email: account['email'],
              firstName: account['firstName'],
              lastName: account['lastName'],
              bornDate: account['bornDate'],
              createdDate: account['createdDate'],
              spentMinutesReadinAndWatching: account['spentMinutesReadingAndWatching'],
              platforms: (preferences != null) ? List<String>.from(preferences['platforms']): [],
              booksGenres: (preferences != null) ? List<String>.from(preferences['booksGenres']): [],
              moviesGenres: (preferences != null) ? List<int>.from(preferences['moviesGenres']): []);
          print('0.2');
          return acc;
        }
      }
    } on DioException {
      rethrow;
    } catch (dioError) {
      rethrow;
    }
    return null;
  }
}
