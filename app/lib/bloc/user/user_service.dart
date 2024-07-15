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
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';

class UserService {
  final Dio dio = Dio();

  UserService(String cookiePath) {
        dio.interceptors.add(CookieManager(PersistCookieJar(
                ignoreExpires: true,
                storage: FileStorage(cookiePath))));
  }

  Future<Account?> getSession() async {
    try {
      final Response response = await dio.get('${ApiConstants.rootApiPath}${ApiConstants.session}');
      if (response.statusCode == HttpStatus.OK) {
        if (response.data['account'] != null) {
          final account = response.data['account'];
          final preferences = account['preferences'];
          ///preferences check null:
          final List<dynamic> platforms = (preferences != null)
              ? preferences['platforms']: [];
          print(preferences['booksGenres']);
          platforms.removeWhere((element) => element is! String);
          final List<dynamic> booksGenres = (preferences != null)
              ? preferences['booksGenres']: [];
          booksGenres.removeWhere((element) => element is! String);
          final List<dynamic> moviesGenres = (preferences != null)
              ? preferences['moviesGenres']: [];
          moviesGenres.removeWhere((element) => element is! int);
          ///account:
          Account acc = Account(
              id: account['id'],
              isVerified: account['isVerified'],
              email: account['email'],
              firstName: account['firstName'],
              lastName: account['lastName'],
              bornDate: account['bornDate'],
              createdDate: account['createdDate'],
              spentMinutesReadinAndWatching: account['spentMinutesReadingAndWatching'],
              platforms: List<String>.from(platforms),
              booksGenres: List<String>.from(booksGenres),
              moviesGenres: List<int>.from(moviesGenres));
          return acc;
        }
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return null;
  }
}
