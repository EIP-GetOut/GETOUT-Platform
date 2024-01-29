/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';

class BookService {
  Future<InfoBookResponse> getInfoBook(CreateInfoBookRequest request) async {
    InfoBookResponse result =
        const InfoBookResponse(statusCode: HttpStatus.APP_ERROR);
    final dio = Dio();

    final response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoBookPath}/${request.id}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response.statusCode != InfoBookResponse.success) {
        return InfoBookResponse(statusCode: response.statusCode ?? 500);
      }
      final bool isOverviewEmpty = (response.data['book']['overview'] == '');
      final bool isDurationEmpty = (response.data['book']['duration'] == '0h0min');

      result = InfoBookResponse(
          title: response.data['book']['title'],
          overview: isOverviewEmpty
              ? response.data['book']['overview']
              : 'Pas de description disponible',
          posterPath: response.data['book']['poster_path'],
          backdropPath: response.data['book']['backdrop_path'],
          releaseDate: response.data['book']['release_date'],
          voteAverage: response.data['book']['vote_average'],
          duration: isDurationEmpty
              ? response.data['book']['duration']
              : 'N/A',
          statusCode: response.statusCode ?? 500);
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const InfoBookResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}
