/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

import 'dart:convert';

import 'package:getout/models/requests/info_movie.dart';
import 'package:getout/models/requests/generate_movies.dart';
import 'package:getout/models/requests/create_account.dart';
import 'package:getout/models/requests/get_session.dart';
import 'package:getout/models/requests/login.dart';
import 'package:http/http.dart' as http;

import 'package:getout/constants/http_status.dart';
import 'package:getout/constants/api_path.dart' as api_constants;

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
      if (response.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching movies: ${response.reasonPhrase}',
        ));
      }

      var data = jsonDecode(response.body);
      GenerateMoviesResponse result = [];

      data['movies'].forEach((elem) {
        // print(elem['overview']);
        result.add(MoviePreview(
            id: elem['id'], title: elem['title'], posterPath: elem['poster']));
        //  , overview: elem['overview']
        // duration: elem['duration']
      });

      return result;
    }, onError: (error) {
      // TODO Handle Error
    });
  }

  Future<InfoMovieResponse> getInfoMovie(CreateInfoMovieRequest request) async {
    InfoMovieResponse result = InfoMovieResponse(statusCode: HttpStatus.APP_ERROR);
    final Uri url = Uri.http(api_constants.rootApiPath, '${api_constants.getInfoMovieApiPath}/${request.id}');
    final Map<String, String> header = {'Content-Type': 'application/json'};

    try {
      final http.Response response =
      await http.get(url, headers: header);
      if (response.statusCode != InfoMovieResponse.success) {
        return InfoMovieResponse(statusCode: response.statusCode);
      }
      final dynamic data = jsonDecode(response.body);
      result = InfoMovieResponse(
          title: data['movie']['title'],
          overview: data['movie']['overview'],
          posterPath: data['movie']['poster_path'],
          backdropPath: data['movie']['backdrop_path'],
          releaseDate: data['movie']['release_date'],
          voteAverage: data['movie']['vote_average'],
          duration: data['movie']['duration'],
          statusCode: response.statusCode);
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() == 'Connection closed before full header was received') {
        return InfoMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }

  Future<LoginResponseInfo> login(LoginRequest request) async {
    final Uri url =
        Uri.http(api_constants.rootApiPath, api_constants.loginApiPath);
    final Map<String, String> header = {'Content-Type': 'application/json'};
    final String body =
        jsonEncode({'email': request.email, 'password': request.password});

    try {
      final http.Response response =
          await http.post(url, body: body, headers: header);
      if (response.statusCode != HttpStatus.CREATED) {
        return LoginResponseInfo(statusCode: response.statusCode);
      }
      final dynamic data = jsonDecode(response.body);
      final LoginResponseInfo result = LoginResponseInfo(
          id: data['id'],
          email: data['email'],
          password: data['password'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          bornDate: data['bornDate'],
          statusCode: response.statusCode);
      return result;
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return LoginResponseInfo(statusCode: HttpStatus.NO_INTERNET); // 'No internet connection';
      }
      return LoginResponseInfo(statusCode: HttpStatus.APP_ERROR);
    }
  }

  Future<AccountResponseInfo> register(CreateAccountRequest request) async {
    AccountResponseInfo result =
        AccountResponseInfo(statusCode: HttpStatus.APP_ERROR);
    final Uri url =
        Uri.http(api_constants.rootApiPath, api_constants.signupApiPath);
    final Map<String, String> header = {'Content-Type': 'application/json'};
    final String body = jsonEncode({
      'email': request.email,
      'firstName': request.firstName,
      'lastName': request.lastName,
      'bornDate': request.bornDate,
      'salt': 'sdjqshjodijaoz',
      'password': request.password
    });

    try {
      final http.Response response =
          await http.post(url, body: body, headers: header);
      if (response.statusCode != HttpStatus.CREATED) {
        return AccountResponseInfo(statusCode: response.statusCode);
      }
      final dynamic data = jsonDecode(response.body);
      result = AccountResponseInfo(
          id: data['id'],
          email: data['email'],
          password: data['password'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          bornDate: data['bornDate'],
          statusCode: response.statusCode);
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return AccountResponseInfo(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }

  Future<SessionResponseInfo> session() async
  {
    final Uri url = Uri.http(api_constants.rootApiPath, api_constants.getSessionApiPath);
    final Map<String, String> header = {
      'Content-Type': 'application/json'
    };

    try {
      final http.Response response = await http.get(url, headers: header);
        if (response.statusCode != HttpStatus.OK) {
          return SessionResponseInfo(statusCode: response.statusCode);
        }
        final dynamic data = jsonDecode(response.body);
        final SessionResponseInfo result = SessionResponseInfo(
            cookie: data,
            statusCode: response.statusCode);
      return result;
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' || error.toString() == 'Connection closed before full header was received') {
        return SessionResponseInfo(statusCode: HttpStatus.NO_INTERNET); // 'No internet connection';
      }
      return SessionResponseInfo(statusCode: HttpStatus.APP_ERROR);
    }
  }
}
