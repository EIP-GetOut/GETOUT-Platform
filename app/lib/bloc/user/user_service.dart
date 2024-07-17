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
        ignoreExpires: true, storage: FileStorage(cookiePath))));
  }

  Future<Account?> getSession() async {
    try {
      final Response response =
          await dio.get('${ApiConstants.rootApiPath}${ApiConstants.session}');
      if (response.statusCode == HttpStatus.OK) {
        if (response.data['account'] != null) {
          final account = response.data['account'];
          final preferences = account['preferences'];

          ///preferences check null:
          final List<String> platforms;
          final List<String> booksGenres;
          final List<int> moviesGenres;
          if (preferences != null) {
            print(preferences);
            print('x');
            platforms = List<String>.from(preferences['platforms']);
            //platforms.removeWhere((element) => element is! String);
            print('y');
            booksGenres = List<String>.from(preferences['booksGenres']);
            //booksGenres.removeWhere((element) => element is! String);
            print('z');
            moviesGenres = List<int>.from(preferences['moviesGenres']);
            print('w');
            //moviesGenres.removeWhere((element) => element is! int);
          } else {
            platforms = [];
            booksGenres = [];
            moviesGenres = [];
          }

          ///account:
          print('>>');
          Account acc = Account(
              id: account['id'],
              isVerified: account['isVerified'],
              email: account['email'],
              firstName: account['firstName'],
              lastName: account['lastName'],
              bornDate: account['bornDate'],
              createdDate: account['createdDate'],
              spentMinutesReadinAndWatching:
                  account['spentMinutesReadingAndWatching'],
              preferences: (preferences != null)
                  ? Preferences(
                      platforms: platforms,
                      booksGenres: booksGenres,
                      moviesGenres: moviesGenres)
                  : null);
          print('<<');
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
