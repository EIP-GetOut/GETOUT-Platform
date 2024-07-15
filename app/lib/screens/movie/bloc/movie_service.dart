/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';

class MovieService {
  final Dio dio = Dio();
  final String accountId;

  MovieService(String cookiePath, this.accountId) {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
  }

  PersonList parseCast(final castData) {
    PersonList castList = [];

        for (final actor in castData) {
          String? name = actor['name'];
          String picture = actor['picture'] ??
              'https://t3.ftcdn.net/jpg/05/03/24/40/360_F_503244059_fRjgerSXBfOYZqTpei4oqyEpQrhbpOML.jpg';

          if (name != null) {
            castList.add(Person(name: name, picture: picture));
          }
        }

    return castList;
  }

  Person parseDirector(final directorData) {

    String name = directorData['name'];
    String picture = directorData['picture'] ??
        'https://t3.ftcdn.net/jpg/05/03/24/40/360_F_503244059_fRjgerSXBfOYZqTpei4oqyEpQrhbpOML.jpg';

    return Person(name: name, picture: picture);
  }

  Future<InfoMovieResponse> getInfoMovie(CreateInfoMovieRequest request) async {
    InfoMovieResponse result =
        const InfoMovieResponse(statusCode: HttpStatus.APP_ERROR);

    final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/${request.id}');
    try {
      if (response.statusCode != HttpStatus.OK) {
        return InfoMovieResponse(statusCode: response.statusCode ?? 500);
      }
      final dynamic data = response.data;

      result = InfoMovieResponse(
          title: data['movie']['title'],
          overview:
              data['movie']['overview'] ?? 'Pas de description disponible',
          posterPath: data['movie']['poster_path'],
          backdropPath: data['movie']['backdrop_path'],
          releaseDate: data['movie']['release_date'],
          voteAverage: data['movie']['vote_average'],
          duration: (data['movie']['duration'].toString() == '0')
              ? 'N/A'
              : data['movie']['duration'],
          cast: parseCast(data['movie']['cast']),
          director: parseDirector(data['movie']['director']),
          statusCode: response.statusCode ?? 500,
          liked: false, //todo globals.session?['likedMovies'].contains(request.id),
          disliked: false, //todo globals.session?['dislikedMovies'].contains(request.id),
          wishlisted: false, //todo globals.session?['watchlist'].contains(request.id),
          seen: false, //todo globals.session?['seenMovies'].contains(request.id),
          id: request.id);
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const InfoMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> addLikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addLikedMoviePath}',
          data: {'movieId': request.id});
      if (response.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddMovieResponse> removeLikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addLikedMoviePath}/${request.id}');
      if (response.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddMovieResponse> removeDislikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addDislikedMoviePath}/${request.id}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddMovieResponse> addDislikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addDislikedMoviePath}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: {'movieId': request.id});

      if (response.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddMovieResponse> addWishlistedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.watchlistPath}',
          data: {'movieId': request.id});
      if (response.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddMovieResponse> removeWishlistedMovie(
      AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.watchlistPath}/${request.id}');
      if (response.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddMovieResponse> addSeenMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.seenMoviesPath}',
          data: {'movieId': request.id});
      if (response.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddMovieResponse> removeSeenMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.seenMoviesPath}/${request.id}');
      if (response.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }
}
