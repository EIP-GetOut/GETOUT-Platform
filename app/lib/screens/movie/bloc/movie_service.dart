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
      print("test = ");
      print(globals.session?['likedMovies']);
      // print(data);
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
          duration: (data['movie']['duration'] == '0h0min')
              ? 'N/A'
              : data['movie']['duration'],
          cast: parseCast(data['movie']['cast']),
          statusCode: response?.statusCode ?? 500);
          // liked:
          //     globals.session?['likedMovies'].contains(request.id),
          // disliked: globals.session?['dislikedMovies']
          //     .contains(request.id),
          // wishlisted:
          //     globals.session?['watchlist'].contains(request.id),
          // id: request.id);
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

  Future<AddLikeMovieResponse> addLikeMovie(AddLikeMovieRequest request) async {
    AddLikeMovieResponse result =
        const AddLikeMovieResponse(statusCode: HttpStatus.APP_ERROR);

    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId/${ApiConstants.addLikedMoviePath}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'movieId': request.id});
    try {
      if (response?.statusCode != AddLikeMovieResponse.success) {
        return AddLikeMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddLikeMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const AddLikeMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }

  Future<AddLikeMovieResponse> addLikedMovie(
      AddLikeMovieRequest request) async {
    AddLikeMovieResponse result =
        const AddLikeMovieResponse(statusCode: HttpStatus.APP_ERROR);

    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId/${ApiConstants.addDislikedMoviePath}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'movieId': request.id});
    try {
      if (response?.statusCode != AddLikeMovieResponse.success) {
        return AddLikeMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddLikeMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const AddLikeMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }

  Future<AddLikeMovieResponse> addDislikedMovie(
      AddLikeMovieRequest request) async {
    AddLikeMovieResponse result =
        const AddLikeMovieResponse(statusCode: HttpStatus.APP_ERROR);

    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId/${ApiConstants.addDislikedMoviePath}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'movieId': request.id});
    try {
      if (response?.statusCode != AddLikeMovieResponse.success) {
        return AddLikeMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddLikeMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const AddLikeMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }

  Future<AddLikeMovieResponse> addWishlistMovie(
      AddLikeMovieRequest request) async {
    AddLikeMovieResponse result =
        const AddLikeMovieResponse(statusCode: HttpStatus.APP_ERROR);

    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId/${ApiConstants.watchlistPath}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'movieId': request.id});
    try {
      if (response?.statusCode != AddLikeMovieResponse.success) {
        return AddLikeMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddLikeMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const AddLikeMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }

  Future<AddLikeMovieResponse> addSeenMovie(AddLikeMovieRequest request) async {
    AddLikeMovieResponse result =
        const AddLikeMovieResponse(statusCode: HttpStatus.APP_ERROR);

    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId/${ApiConstants.addDislikedMoviePath}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'movieId': request.id});
    try {
      if (response?.statusCode != AddLikeMovieResponse.success) {
        return AddLikeMovieResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddLikeMovieResponse(
        statusCode: response?.statusCode ?? 500,
      );
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const AddLikeMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}
