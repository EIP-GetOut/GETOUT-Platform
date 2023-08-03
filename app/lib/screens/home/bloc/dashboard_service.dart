/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'dart:convert';

import 'package:http/http.dart' as http;

// import 'package:getout/models/home/generate_movies.dart';

// import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/home/bloc/movie_bloc.dart';
import 'package:getout/constants/api_path.dart' as api_constants;

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

class DashboardService {
  String formatWithGenresParameter(List<int> genres) {
    String withGenres = '';

    for (int genre in genres) {
      withGenres += '$genre,';
    }
    withGenres = withGenres.substring(0, withGenres.length - 1);
    return withGenres;
  }

  Future<GenerateMoviesResponse> getMovies(
      GenerateMoviesRequest request) async {
    print("test1");
    String withGenres = formatWithGenresParameter(request.genres);

    final dio = Dio();

    print("test2");
    // final Response response = (kDebugMode)
    //     ? await dio.request(
    //         '${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}',
    //         data: {
    //           'with_genres': withGenres,
    //           'include_adult': request.includeAdult.toString()
    //         },
    //         options: Options(method: 'GET'))
    //     : await dio.request(
    //         '${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}',
    //         data: {
    //           'with_genres': withGenres,
    //           'include_adult': request.includeAdult.toString()
    //         },
    //         options: Options(method: 'GET'));
    // '${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}?with_genres=${withGenres}&include_adult=${request.includeAdult.toString()}',

    print('${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}');
    final Response response = await dio.request(
        '${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}?with_genres=${withGenres}&include_adult=${request.includeAdult.toString()}',
        data: {
          'with_genres': withGenres,
          'include_adult': request.includeAdult.toString()
        },
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ));

    print('response = ');
    print(response.statusCode);
    GenerateMoviesResponse result = [];
    return result;
    // if (response.statusCode != HttpStatus.OK) {
    //     return Future.error(Exception(
    //       'Error ${response.statusCode} while fetching movies: ${response.reasonPhrase}',
    //     ));
    //   }

    //   var data = jsonDecode(response.body);
    //   GenerateMoviesResponse result = [];

    //   data['movies'].forEach((elem) {
    //     result.add(MoviePreview(
    //         id: elem['id'],
    //         title: elem['title'],
    //         posterPath: elem['poster'],
    //         overview: elem['overview']));
    //     //  , overview: elem['overview']
    //     // duration: elem['duration']
    //   });

    //   return result;
    // }, onError: (error) {
    //   // TODO Handle Error
    // });
  }

  // Future<List<Genre>> getGenres() async {
  //   final response = await _httpClient.get(
  //     getUrl(url: 'genres'),
  //   );
  //   if (response.statusCode == 200) {
  //     if (response.body.isNotEmpty) {
  //       return List<Genre>.from(
  //         json.decode(response.body)['results'].map(
  //               (data) => Genre.fromJson(data),
  //             ),
  //       );
  //     } else {
  //       throw ErrorEmptyResponse();
  //     }
  //   } else {
  //     throw ErrorGettingGames('Error getting genres');
  //   }
  // }

  // Future<List<Result>> getGamesByCategory(int genreId) async {
  //   final response = await _httpClient.get(
  //     getUrl(
  //       url: 'games',
  //       extraParameters: {
  //         'genres': genreId.toString(),
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     if (response.body.isNotEmpty) {
  //       return List<Result>.from(
  //         json.decode(response.body)['results'].map(
  //               (data) => Result.fromJson(data),
  //             ),
  //       );
  //     } else {
  //       throw ErrorEmptyResponse();
  //     }
  //   } else {
  //     throw ErrorGettingGames('Error getting games');
  //   }
  // }
}
