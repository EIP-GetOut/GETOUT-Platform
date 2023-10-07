/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/home/bloc/movies/movies_bloc.dart';
import 'package:getout/screens/home/bloc/books/books_bloc.dart';
import 'package:getout/constants/api_path.dart' as api_constants;
import 'package:getout/constants/http_status.dart';

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
    String withGenres = formatWithGenresParameter(request.genres);
    GenerateMoviesResponse result = [];
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
      result.add(MoviePreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }

  Future<GenerateBooksResponse> getBooks(GenerateBooksRequest request) async {
    String withGenres = formatWithGenresParameter(request.genres);
    GenerateBooksResponse result = [];
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
      result.add(BookPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }
}
