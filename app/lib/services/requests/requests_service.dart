/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import 'dart:convert';

import 'package:GetOut/models/requests/generate_movies.dart';
import 'package:GetOut/models/requests/create_account.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

import 'package:GetOut/constants/api_path.dart' as api_constants;

String formatWithGenresParameter(List<int> genres) {
  String withGenres = '';

  for (int genre in genres) {
    withGenres += '$genre,';
  }
  withGenres = withGenres.substring(0, withGenres.length - 1);
  return withGenres;
}

class RequestsService {
  RequestsService._();

  static final instance = RequestsService._();

  Future<GenerateMoviesResponse> generateMovies(GenerateMoviesRequest request) {
    String withGenres = formatWithGenresParameter(request.genres);
    Uri url = Uri.http(
        api_constants.rootApiPath, api_constants.generateMoviesApiPath, {
      'with_genres': withGenres,
      'include_adult': request.includeAdult.toString()
    });

    return http.get(url).then((response) {
      if (response.statusCode != StatusCode.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching movies: ${response.reasonPhrase}',
        ));
      }

      var data = jsonDecode(response.body);
      GenerateMoviesResponse result = [];

      data['movies'].forEach((elem) {
        result.add(MoviePreview(
            id: elem['id'], title: elem['title'], posterPath: elem['poster']));
      });

      return result;
    }, onError: (eror) {
      // TODO
    });
  }

  Future<AccountCreated?> register(CreateAccountRequest request) async
  {
    var url = Uri.http(api_constants.rootApiPath, api_constants.signupApiPath);
    var body = jsonEncode({
    'email': request.email,
    'firstName': request.firstName,
    'lastName': request.lastName,
    'bornDate': request.bornDate,
    'salt': 'sdjqshjodijaoz',
    'password': request.password
    });

    try {
      return http.post(url, body: body,  headers: {
        'Content-Type': 'application/json'
      }).then((response) {
        if (response.statusCode != StatusCode.OK) {
          return Future.error(Exception(
            'Error ${response.statusCode} while creating account: ${response.reasonPhrase}',
          ));
        }

        var data = jsonDecode(response.body);
        AccountCreated result = AccountCreated(id: data['id'],
        email: data['email'],
        password: data['password'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        bornDate: data['bornDate'],
        salt: data['salt']);

        return result;
      }, onError: (error) {
        print(error);
        // console.log('error : requests service line 89');
      });
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' || error.toString() == 'Connection closed before full header was received') {
        return null; // 'No internet connection';
      }
      return null; // error.toString();
    }
  }
}
