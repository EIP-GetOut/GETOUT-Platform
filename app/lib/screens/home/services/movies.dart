/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class MoviesService extends ServiceTemplate {
  final String _id = globals.session?['id'].toString() ?? '';

  MoviesService();

  // RECOMMEND
  Future<GenerateMoviesResponse> getRecommendedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    try {
      final response = await globals.dio?.get(
          '${ApiConstants.rootApiPath}/account/$_id${ApiConstants.recommendedMoviesPath}',
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response?.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response?.statusCode} while fetching movies: ${response?.statusMessage}',
        ));
      }

      response?.data.forEach((elem) {
        result.add(MoviePreview(
            id: elem['id'],
            title: elem['title'],
            posterPath: elem['poster_path'],
            overview: elem['overview']));
      });
    } on DioException catch (dioException) {
      if (dioException.response != null &&
          dioException.response?.statusCode != null) {
        return Future.error(Exception(
          'Error ${dioException.response?.statusCode} while fetching movies: ${dioException.response?.statusMessage}',
        ));
      }
      return Future.error(
          Exception('Unknown error:  ${dioException.toString()}'));
    } catch (error) {
      return Future.error(Exception('Unknown error:  ${error.toString()}'));
    }
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
        result.add(MoviePreview(
            id: item.id!,
            title: item.title!,
            posterPath: item.posterPath!,
            overview: item.overview));
      }
    }
    return result;
  }

  Future<dynamic> getLikedMoviesId(GenerateMoviesRequest request) async {
    final Response? response;

    response = await globals.dio
        ?.get('${ApiConstants.rootApiPath}/account/$_id/likedMovies',
            options: Options(headers: {
              'Content-Type': 'application/json',
            }));
    if (response?.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response?.statusCode} while fetching movies: ${response?.statusMessage}',
      ));
    }
    return response?.data;
  }

// SAVED

  Future<GenerateMoviesResponse> getSavedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    dynamic data = await getSavedMoviesId(request);

    print(data);
    for (int movie in data) {
      print("avant item");
      MovieStatusResponse item = await getMovieById(movie);
      print(item.id);
      print(item.title);
      print(item.posterPath);
      print(item.overview);
      if (item.statusCode == HttpStatus.OK) {
        result.add(MoviePreview(
            id: item.id!,
            title: item.title!,
            posterPath: item.posterPath!,
            overview: item.overview!));
      }
    }
    return result;
  }

  Future<dynamic> getSavedMoviesId(GenerateMoviesRequest request) async {
    dynamic data;

    final response = await globals.dio
        ?.get('${ApiConstants.rootApiPath}/account/$_id/watchlist',
            options: Options(headers: {
              'Content-Type': 'application/json',
            }));

    if (response?.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response?.statusCode} while fetching movies: ${response?.statusMessage}',
      ));
    }

    data = response?.data;

    return data;
  }

  //Info
  Future<MovieStatusResponse> getMovieById(int movie) async {
    MovieStatusResponse result =
        const MovieStatusResponse(statusCode: HttpStatus.APP_ERROR);

    final Response? response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/$movie',
        options: Options(headers: {'Content-Type': 'application/json'}));
    //     print("data = ");
    // print(response?.data);
    try {
      if (response?.statusCode != MovieStatusResponse.success) {
        return const MovieStatusResponse(
            statusCode: HttpStatus.INTERNAL_SERVER_ERROR);
      }
      final dynamic data = response?.data;
      result = MovieStatusResponse(
          title: data['movie']['title'],
          overview:
              data['movie']['overview'] ?? 'Pas de description disponible',
          posterPath: data['movie']['poster_path'],
          id: movie,
          statusCode: response?.statusCode ?? HttpStatus.INTERNAL_SERVER_ERROR);
    } catch (error) {
      print("ERORRRRR : ");
      print(error);
    }
    print(result.id);
    print(result.title);
    print(result.overview);
    print(result.posterPath);
    return result;
  }
}
