/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class MoviesService extends ServiceTemplate {
  final String _id = globals.session?['id'].toString() ?? '';
  final Dio dio = Dio(globals.dioOptions);

  MoviesService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true, storage: FileStorage(globals.cookiePath))));
  }

  // RECOMMEND
  Future<GenerateMoviesResponse> getRecommendedMovies(
      GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];

    try {
      final Response response = await dio.get(
        '${ApiConstants.rootApiPath}/account/$_id${ApiConstants.recommendedMoviesPath}',
      );

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
    try {
      final Response response =
          await dio.get('${ApiConstants.rootApiPath}/account/$_id/likedMovies');
      if (response.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
        ));
      }
      return response.data;
    } on DioException {
      return;
    } catch (error) {
      return;
    }
  }

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
    try {
      final Response response =
          await dio.get('${ApiConstants.rootApiPath}/account/$_id/watchlist');
      if (response.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
        ));
      }
      return response.data;
    } on DioException {
      return;
    } catch (error) {
      return;
    }
  }

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
    try {
      final Response response =
          await dio.get('${ApiConstants.rootApiPath}/account/$_id/seenMovies');
      if (response.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching movies: ${response.statusMessage}',
        ));
      }
      return response.data;
    } on DioException {
      return;
    } catch (error) {
      return;
    }
  }

  //Info
  Future<MovieStatusResponse> getMovieById(int movie) async {
    MovieStatusResponse result =
        const MovieStatusResponse(statusCode: HttpStatus.APP_ERROR);

    /// TODO Erwan -> Inès why is it outside the try catch ?
    try {
      final Response response = await dio.get(
          '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/$movie');
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
    StoryNewsResponse result =
        const StoryNewsResponse(statusCode: HttpStatus.APP_ERROR);
    try {
      final Response response =
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
    NewsResponse result = const NewsResponse(statusCode: HttpStatus.APP_ERROR);
    DateTime now = DateTime.now();
    int dayOfYear = int.parse('${now.month}${now.day}');
    int index = 0;

    try {
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
