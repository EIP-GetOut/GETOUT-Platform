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

class MovieService {
  Future<InfoMovieResponse> getInfoMovie(CreateInfoMovieRequest request) async {
    InfoMovieResponse result =
        const InfoMovieResponse(statusCode: HttpStatus.APP_ERROR);
    final dio = Dio();

    final response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/${request.id}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response.statusCode != InfoMovieResponse.success) {
        return InfoMovieResponse(statusCode: response.statusCode ?? 500);
      }
      final dynamic data = response.data;
      result = InfoMovieResponse(
          title: data['movie']['title'],
          overview: data['movie']['overview'] ?? 'Pas de description disponible',
          posterPath: data['movie']['poster_path'],
          backdropPath: data['movie']['backdrop_path'],
          releaseDate: data['movie']['release_date'],
          voteAverage: data['movie']['vote_average'],
          duration: (data['movie']['duration'] == '0h0min')
              ? 'N/A' : data['movie']['duration'],
          statusCode: response.statusCode ?? 500);
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
}
