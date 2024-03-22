/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';

import 'package:getout/global.dart' as globals;

class MovieService {
  final String userId = globals.session?['id'].toString() ?? '';

  Future<InfoMovieResponse> getInfoMovie(CreateInfoMovieRequest request) async {
    InfoMovieResponse result =
        const InfoMovieResponse(statusCode: HttpStatus.APP_ERROR);

    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/${request.id}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response?.statusCode != InfoMovieResponse.success) {
        return InfoMovieResponse(statusCode: response?.statusCode ?? 500);
      }
      final dynamic data = response?.data;
      List<Map<String, String?>> parseCast(dynamic castData) {
        List<Map<String, String?>> castList = [];

        if (castData is List) {
          for (var actor in castData) {
            if (actor is Map<String, dynamic>) {
              String? name = actor['name'];
              String? picture = actor['picture'];

              if (name != null && picture != null) {
                castList.add({'name': name, 'picture': picture});
              }
            }
          }
        }

        return castList;
      }

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
          statusCode: response?.statusCode ?? 500,
          liked: globals.session?['likedMovies'].contains(request.id),
          disliked: globals.session?['dislikedMovies'].contains(request.id),
          wishlisted: globals.session?['watchlist'].contains(request.id),
          seen: globals.session?['seenMovies'].contains(request.id),
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
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addLikedMoviePath}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: {'movieId': request.id});
      if (response?.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
      await globals.sessionManager.getSession();
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
      final response = await globals.dio?.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addLikedMoviePath}/${request.id}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response?.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
      await globals.sessionManager.getSession();
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
      final response = await globals.dio?.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedMoviePath}/${request.id}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response?.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );

      await globals.sessionManager.getSession();
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
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedMoviePath}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: {'movieId': request.id});

      if (response?.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );

      await globals.sessionManager.getSession();
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
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.watchlistPath}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: {'movieId': request.id});
      if (response?.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
      await globals.sessionManager.getSession();
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
      final response = await globals.dio?.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.watchlistPath}/${request.id}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));
      if (response?.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
      await globals.sessionManager.getSession();
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
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.seenMoviesPath}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: {'movieId': request.id});
      if (response?.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
      await globals.sessionManager.getSession();
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
      final response = await globals.dio?.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.seenMoviesPath}/${request.id}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));
      if (response?.statusCode != HttpStatus.OK) {
        return AddMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
      await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }
}
