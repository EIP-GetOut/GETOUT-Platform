/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/constants/api_path.dart' as api_constants;
import 'package:getout/constants/http_status.dart';

class MovieService {
  Future<InfoMovieResponse> getInfoMovie(CreateInfoMovieRequest request) async {
    InfoMovieResponse result =
        InfoMovieResponse(statusCode: HttpStatus.APP_ERROR);
    final dio = Dio();

    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.getInfoMovieApiPath}/${request.id}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response.statusCode != InfoMovieResponse.success) {
        return InfoMovieResponse(statusCode: response.statusCode ?? 500);
      }
      final dynamic data = response.data;
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
        overview: data['movie']['overview'],
        posterPath: data['movie']['poster_path'],
        backdropPath: data['movie']['backdrop_path'],
        releaseDate: data['movie']['release_date'],
        voteAverage: data['movie']['vote_average'],
        duration: data['movie']['duration'],
        cast: parseCast(data['movie']['cast']),
        statusCode: response.statusCode ?? 500,
      );

      if (result.overview == '') {
        result.overview = 'Pas de description disponible';
      }
      if (result.duration == '0h0min') {
        result.duration = 'N/A';
      }
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return InfoMovieResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}
