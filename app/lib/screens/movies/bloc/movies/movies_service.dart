/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/movies/bloc/movies_liked/movies_liked_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_recommended/movies_recommended_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_saved/movies_saved_bloc.dart';
import 'package:getout/constants/api_path.dart' as api_constants;
import 'package:getout/constants/http_status.dart';

class MoviesService {
  // LIKED
  Future<GenerateMoviesLikedResponse> getMoviesLiked(
      GenerateMoviesLikedRequest request) async {
    GenerateMoviesLikedResponse result = [];

    dynamic data = await getMoviesIdLiked(request);
    dynamic movies = [];

    for (int movie in data) {
      MoviesLikeResponse item = await getInfoMovieLiked(movie);
      if (item.statusCode == HttpStatus.OK) {
        movies.add(item);
      }
    }

    for (int i = 0; i < movies.length; i++) {
      result.add(MovieLikedPreview(
          id: movies[i].id,
          title: movies[i].title,
          posterPath: movies[i].posterPath,
          overview: movies[i].overview));
    }
    return result;
  }

Future<dynamic> getMoviesIdLiked(GenerateMoviesLikedRequest request) async {
  dynamic data;

  final dio = Dio();
  final response = await dio.get(
      // A changer avec le account id quand le get session sera fait
      '${api_constants.rootApiPath}/account/fe1b3ea3-1434-4d09-8543-b00af79889d6/likedMovies',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Cookie':
            'connect.sid=s%3ABvubf9YeIjX9sZNSMFKSlQX93ZXFziDS.DVpF1Xq%2BSPxyKMAbKfZW1Tc3jQ%2F5fcLSl%2FMtk2Glt6o'
      }));

  if (response.statusCode != HttpStatus.OK) {
    return Future.error(Exception(
      'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
    ));
  }

  data = response.data;

  return data;
}

Future<MoviesLikeResponse> getInfoMovieLiked(var movie) async {
  MoviesLikeResponse result = MoviesLikeResponse(
      id: null,
      title: null,
      posterPath: null,
      statusCode: HttpStatus.APP_ERROR,
      overview: null);
  final dio = Dio();

  final response = await dio.get(
      '${api_constants.rootApiPath}${api_constants.getInfoMovieApiPath}/account/60eee6af-2ba2-4ff0-ba79-7c6d6c50634f/likedMovies',
      options: Options(headers: {'Content-Type': 'application/json'}));
  try {
    if (response.statusCode != MoviesLikeResponse.success) {
      MoviesLikeResponse(
          id: null,
          title: null,
          posterPath: null,
          statusCode: 500,
          overview: null);
    }
    final dynamic data = response.data;
    result = MoviesLikeResponse(
        title: data['movie']['title'],
        overview: data['movie']['overview'],
        posterPath: data['movie']['poster_path'],
        id: movie,
        statusCode: response.statusCode ?? 500);
    if (result.overview == '') {
      result.overview = 'Pas de description disponible';
    }
  } catch (error) {
    if (error.toString() == 'Connection reset by peer' ||
        error.toString() ==
            'Connection closed before full header was received') {
      return MoviesLikeResponse(
          id: null,
          title: null,
          posterPath: null,
          statusCode: HttpStatus.NO_INTERNET,
          overview: null);
    }
    return result;
  }
  return result;
}

// RECOMMAND

String formatWithGenresParameter(List<int> genres) {
  String withGenres = '';

  for (int genre in genres) {
    withGenres += '$genre,';
  }
  withGenres = withGenres.substring(0, withGenres.length - 1);
  return withGenres;
}

Future<GenerateMoviesRecommendedResponse> getMoviesRecommended(
    GenerateMoviesRecommendedRequest request) async {
  String withGenres = formatWithGenresParameter(request.genres);
  GenerateMoviesRecommendedResponse result = [];
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
    result.add(MovieRecommendedPreview(
        id: elem['id'],
        title: elem['title'],
        posterPath: elem['poster'],
        overview: elem['overview']));
  });
  return result;
}

// SAVED

Future<GenerateMoviesSavedResponse> getMoviesSaved(
    GenerateMoviesSavedRequest request) async {
  GenerateMoviesSavedResponse result = [];

  dynamic data = await getMoviesIdSaved(request);
  dynamic movies = [];

  for (int movie in data) {
    MoviesSaveResponse item = await getInfoMovie(movie);
    if (item.statusCode == HttpStatus.OK) {
      movies.add(item);
    }
  }

  for (int i = 0; i < movies.length; i++) {
    print(movies[i].id);
    result.add(MovieSavedPreview(
        id: movies[i].id,
        title: movies[i].title,
        posterPath: movies[i].posterPath,
        overview: movies[i].overview));
  }
  return result;
}

Future<dynamic> getMoviesIdSaved(GenerateMoviesSavedRequest request) async {
  dynamic data;

  final dio = Dio();
  final response = await dio.get(
      // A changer avec le account id quand le get session sera fait
      '${api_constants.rootApiPath}/account/fe1b3ea3-1434-4d09-8543-b00af79889d6/watchlist',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Cookie':
            'connect.sid=s%3ABvubf9YeIjX9sZNSMFKSlQX93ZXFziDS.DVpF1Xq%2BSPxyKMAbKfZW1Tc3jQ%2F5fcLSl%2FMtk2Glt6o'
      }));

  if (response.statusCode != HttpStatus.OK) {
    return Future.error(Exception(
      'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
    ));
  }

  data = response.data;

  return data;
}

Future<MoviesSaveResponse> getInfoMovie(var movie) async {
  MoviesSaveResponse result = MoviesSaveResponse(
      id: null,
      title: null,
      posterPath: null,
      statusCode: HttpStatus.APP_ERROR,
      overview: null);
  final dio = Dio();

  final response = await dio.get(
      '${api_constants.rootApiPath}${api_constants.getInfoMovieApiPath}/${movie}',
      options: Options(headers: {'Content-Type': 'application/json'}));
  try {
    if (response.statusCode != MoviesSaveResponse.success) {
      MoviesSaveResponse(
          id: null,
          title: null,
          posterPath: null,
          statusCode: 500,
          overview: null);
    }
    final dynamic data = response.data;
    result = MoviesSaveResponse(
        title: data['movie']['title'],
        overview: data['movie']['overview'],
        posterPath: data['movie']['poster_path'],
        id: movie,
        statusCode: response.statusCode ?? 500);
    if (result.overview == '') {
      result.overview = 'Pas de description disponible';
    }
  } catch (error) {
    if (error.toString() == 'Connection reset by peer' ||
        error.toString() ==
            'Connection closed before full header was received') {
      return MoviesSaveResponse(
          id: null,
          title: null,
          posterPath: null,
          statusCode: HttpStatus.NO_INTERNET,
          overview: null);
    }
    return result;
  }
  return result;
}
}