/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/movies/bloc/movies_liked/movies_liked_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_recommanded/movies_recommanded_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_saved/movies_saved_bloc.dart';
import 'package:getout/constants/api_path.dart' as api_constants;
import 'package:getout/constants/http_status.dart';

class MoviesService {
  String formatWithGenresParameter(List<int> genres) {
    String withGenres = '';

    for (int genre in genres) {
      withGenres += '$genre,';
    }
    withGenres = withGenres.substring(0, withGenres.length - 1);
    return withGenres;
  }

  Future<GenerateMoviesLikedResponse> getMoviesLiked(
      GenerateMoviesLikedRequest request) async {
    String withGenres = formatWithGenresParameter(request.genres);
    GenerateMoviesLikedResponse result = [];
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}?with_genres=$withGenres&include_adult=${request.includeAdult.toString()}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }

    data = response.data;
    data['movies'].forEach((elem) {
      result.add(MovieLikedPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }

  Future<GenerateMoviesRecommandedResponse> getMoviesRecommanded(
      GenerateMoviesRecommandedRequest request) async {
    String withGenres = formatWithGenresParameter(request.genres);
    GenerateMoviesRecommandedResponse result = [];
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}?with_genres=$withGenres&include_adult=${request.includeAdult.toString()}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }

    data = response.data;
    data['movies'].forEach((elem) {
      result.add(MovieRecommandedPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }

  Future<GenerateMoviesSavedResponse> getMoviesSaved(
      GenerateMoviesSavedRequest request) async {
    String withGenres = formatWithGenresParameter(request.genres);
    GenerateMoviesSavedResponse result = [];
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.generateMoviesApiPath}?with_genres=$withGenres&include_adult=${request.includeAdult.toString()}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }

    data = response.data;
    data['movies'].forEach((elem) {
      result.add(MovieSavedPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }
}
