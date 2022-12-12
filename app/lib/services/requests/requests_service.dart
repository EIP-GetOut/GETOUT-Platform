/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

// import 'dart:convert';

import 'package:getout/models/requests/generate_movies.dart';
import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

import 'package:getout/constants/api_path.dart' as constants;

class RequestsService {
  RequestsService._();

  static final instance = RequestsService._();

  Future<GenerateMoviesResponse> generateMovies(GenerateMoviesRequest request) {
    var url = Uri.http(constants.rootApiPath, constants.generateMoviesApiPath, {
      'with_genres': request.withGenres,
      'include_adult': request.includeAdult.toString()
    });

    return http.get(url).then((response) {
      if (response.statusCode != StatusCode.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching movies: ${response.reasonPhrase}',
        ));
      }

      // var data = jsonDecode(response.body);
      // print(data);
      return [
        MoviePreview(
            id: 436270,
            title: 'Black Adam',
            posterPath: '/pFlaoHTZeyNkG83vxsAJiGzfSsa.jpg'),
        MoviePreview(
            id: 736526,
            title: 'Troll',
            posterPath: '/9z4jRr43JdtU66P0iy8h18OyLql.jpg'),
        MoviePreview(
            id: 72449,
            title: 'The Woman King',
            posterPath: '/lQMJHnHxUyj8kJlC2YOKNuzuwMP.jpg'),
      ];
    }, onError: (eror) {
      // TODO
    });
  }
}
