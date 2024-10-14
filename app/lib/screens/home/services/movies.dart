/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class MoviesService extends ServiceTemplate {
  final String _id = globals.session?['id'].toString() ?? '';
  final Dio dio = Dio();

  MoviesService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(globals.cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
  }

  // RECOMMEND
  Future<GenerateMoviesResponse> getRecommendedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    try {
      final response = await dio.get(
          '${ApiConstants.rootApiPath}/account/$_id${ApiConstants.recommendedMoviesPath}',
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
        ));
      }
      response.data.forEach((elem) {
        result.add(MoviePreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['posterPath'],
          overview: elem['description'],
          releaseDate: elem['releaseDate'],
          averageRating: elem['averageRating'],
          genres: elem['genres'],
        ));
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

  /// LIKED
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

    response =
        await dio.get('${ApiConstants.rootApiPath}/account/$_id/likedMovies',
            options: Options(headers: {
              'Content-Type': 'application/json',
            }));
    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }
    return response.data;
  }

  /// SAVED

  Future<GenerateMoviesResponse> getSavedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    dynamic data = await getSavedMoviesId(request);

    for (int movie in data) {
      MovieStatusResponse item = await getMovieById(movie);

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

    final response =
        await dio.get('${ApiConstants.rootApiPath}/account/$_id/watchlist',
            options: Options(headers: {
              'Content-Type': 'application/json',
            }));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
      ));
    }

    data = response.data;

    return data;
  }

  // WATCHED

  Future<GenerateMoviesResponse> getWatchedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    dynamic data = await getWatchedMoviesId(request);

    for (int movie in data) {
      MovieStatusResponse item = await getMovieById(movie);

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

  Future<dynamic> getWatchedMoviesId(GenerateMoviesRequest request) async {
    dynamic data;

    final response =
        await dio.get('${ApiConstants.rootApiPath}/account/$_id/seenMovies',
            options: Options(headers: {
              'Content-Type': 'application/json',
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

    final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/$movie',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response.statusCode != MovieStatusResponse.success) {
        return const MovieStatusResponse(
            statusCode: HttpStatus.INTERNAL_SERVER_ERROR);
      }
      final dynamic data = response.data;

      result = MovieStatusResponse(
          title: data['title'],
          overview: data['synopsis'] ?? 'Pas de description disponible',
          posterPath: data['posterPath'],
          id: movie,
          statusCode: response.statusCode ?? HttpStatus.INTERNAL_SERVER_ERROR);
    } catch (error) {
      return Future.error(Exception('Unknown error:  ${error.toString()}'));
    }
    return result;
  }

  Future<StoryNewsResponse> getInfoStoryNews() async {
    try {
      StoryNewsResponse result =
          const StoryNewsResponse(statusCode: HttpStatus.APP_ERROR);
      final response =
          await dio.get('${ApiConstants.rootApiPath}${ApiConstants.dailyInfo}');
      if (response.statusCode == HttpStatus.OK) {
        result = StoryNewsResponse(
          statusCode: response.statusCode ?? 500,
          quote: response.data['quote'] ?? '',
          author: response.data['author'] ?? 'Auteur inconnue',
          sourceStr: response.data['sourceStr'] ?? 'Source inconnue',
          sourceUrl: response.data['sourceUrl'] ?? '',
        );
      }
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<NewsResponse> getInfoNews() async {
    DateTime now = DateTime.now();
    int dayOfYear = int.parse('${now.month}${now.day}');
    int index = 0;

    try {
      NewsResponse result =
          const NewsResponse(statusCode: HttpStatus.APP_ERROR);
      final response =
          await dio.get('${ApiConstants.rootApiPath}${ApiConstants.dailyNews}');
      if (response.statusCode == HttpStatus.OK) {
        index = dayOfYear % 5;
        result = NewsResponse(
          statusCode: response.statusCode ?? 500,
          title: response.data[index]['title'] ?? '',
          picture: response.data[index]['image'] ?? '',
          url: response.data[index]['url'] ?? '',
          sourceLogo: response.data[index]['sourceLogo'] ?? '',
        );
      }
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }
}
