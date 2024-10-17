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

import 'package:getout/global.dart' as globals;

class MovieService {
  final String userId = globals.session?['id'].toString() ?? '';
  final Dio dio = Dio(globals.dioOptions);

  MovieService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
  }


  PersonList parseCast(final castData) {
    PersonList castList = [];

        for (final actor in castData) {
          String? name = actor['name'] ?? 'Acteur inconnue';
          String picture = actor['picture'] ??
              'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg';

          if (name != null) {
            castList.add(Person(name: name, picture: picture));
          }
        }

    return castList;
  }

  Person parseDirector(final directorData) {

    String name = directorData['name'] ?? 'Réalisateur inconnue';
    String picture = directorData['picture'] ??
        'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg';

    return Person(name: name, picture: picture);
  }

  Future<InfoMovieResponse> getInfoMovie(CreateInfoMovieRequest request) async {
    InfoMovieResponse result =
        const InfoMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/${request.id}',);
      if (response.statusCode != InfoMovieResponse.success) {
        return InfoMovieResponse(statusCode: response.statusCode ?? HttpStatus.APP_ERROR);
      }
      final dynamic data = response.data;

      result = InfoMovieResponse(
          title: data['title'] ?? 'Titre inconnue',
          overview:
              data['synopsis'] ?? 'Pas de description disponible',
          posterPath: data['posterPath'] ?? 'https://media.comicbook.com/files/img/default-movie.png',
          backdropPath: data['backdropPath'] ?? 'https://media.comicbook.com/files/img/default-movie.png',
          releaseDate: data['releaseDate'],
          voteAverage: data['averageRating'],
          genres: data['genres'],
          duration: (data['duration'].toString() == '0') ? 'N/A' : data['duration'],
          cast: parseCast(data['cast']),
          director: parseDirector(data['director']),
          statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
          liked: globals.session?['likedMovies'].toString().contains(request.id.toString()),
          disliked: globals.session?['dislikedMovies'].toString().contains(request.id.toString()),
          wishlisted: globals.session?['watchlist'].toString().contains(request.id.toString()),
          seen: globals.session?['seenMovies'].toString().contains(request.id.toString()),
          id: request.id);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return InfoMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return InfoMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> addLikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addLikedMoviePath}',
          data: {
            'movieId': request.id
          });
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> removeLikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addLikedMoviePath}/${request.id}',);
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> removeDislikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedMoviePath}/${request.id}',
      );
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> addDislikedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedMoviePath}',
          data: {
            'movieId': request.id
          });
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> addWishListedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.watchlistPath}',
          data: {
            'movieId': request.id
          });
      if (response.statusCode != HttpStatus.CREATED) {
        return AddMovieResponse(statusCode: response.statusCode ?? 500);
      }
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> removeWishListedMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.watchlistPath}/${request.id}',
          );
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> addSeenMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.seenMoviesPath}',
          data: {
            'movieId': request.id
          });
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddMovieResponse> removeSeenMovie(AddMovieRequest request) async {
    AddMovieResponse result =
        const AddMovieResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.seenMoviesPath}/${request.id}',
          );
      result = AddMovieResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddMovieResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddMovieResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }
}
