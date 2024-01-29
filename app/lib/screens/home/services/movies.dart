/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class MoviesService extends ServiceTemplate {
  final Dio dio;

  MoviesService({required this.dio});

  // RECOMMEND
  Future<GenerateMoviesResponse> getRecommendedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];
    String withGenres = formatWithGenresParameter(request.genres);

    final response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.generateMoviesPath}?with_genres=$withGenres&include_adult=${request.includeAdult.toString()}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }

    response.data['movies'].forEach((elem) {
      result.add(MoviePreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          //posterPath: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${elem['poster']}',
          overview: elem['overview']));
    });
    return result;
  }

  // LIKED
  Future<GenerateMoviesResponse> getLikedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    dynamic data = await getLikedMoviesId(request);

    for (int movie in data) {
      MovieStatusResponse item = await getMovieById(movie);
      if (item.statusCode == HttpStatus.OK) {
        final movie = (item as MoviePreview);
        result.add(MoviePreview(
            id: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
            overview: movie.overview));
      }
    }
    return result;
  }

  Future<dynamic> getLikedMoviesId(GenerateMoviesRequest request) async {
    final Response response;
    final dio = Dio();

    response = await dio.get(
        //Todo A changer avec le account id quand le get session sera fait
        '${ApiConstants.rootApiPath}/account/${ApiConstants.token}/likedMovies',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Cookie': ApiConstants.cookies
        }));
    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }
    return response.data;
  }

// SAVED

  Future<GenerateMoviesResponse> getSavedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    dynamic data = await getSavedMoviesId(request);

    for (int movie in data) {
      MovieStatusResponse item = await getMovieById(movie);
      if (item.statusCode == HttpStatus.OK) {
        final movie = (item as MoviePreview);
        result.add(MoviePreview(
            id: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
            overview: movie.overview));
      }
    }
    return result;
  }

  Future<dynamic> getSavedMoviesId(GenerateMoviesRequest request) async {
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        //Todo - A changer avec le account id quand le get session sera fait
        '${ApiConstants.rootApiPath}/account/${ApiConstants.token}/watchlist',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Cookie': ApiConstants.cookies
        }));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }

    data = response.data;

    return data;
  }

  //Info
  Future<MovieStatusResponse> getMovieById(int movie) async {
    MovieStatusResponse result =
        const MovieStatusResponse(statusCode: HttpStatus.APP_ERROR);
    final dio = Dio();

    final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/$movie',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response.statusCode != MovieStatusResponse.success) {
        return const MovieStatusResponse(statusCode: HttpStatus.INTERNAL_SERVER_ERROR);
      }
      //todo
      final dynamic data = response.data;
      result = MovieStatusResponse(
          title: data['movie']['title'],
          overview:
              data['movie']['overview'] ?? 'Pas de description disponible',
          posterPath: data['movie']['poster_path'],
          id: movie,
          statusCode: response.statusCode ?? HttpStatus.INTERNAL_SERVER_ERROR);
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const MovieStatusResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}
