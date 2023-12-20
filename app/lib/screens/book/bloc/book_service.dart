/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/constants/api_path.dart' as api_constants;
import 'package:getout/constants/http_status.dart';

class BookService {
  Future<InfoBookResponse> getInfoBook(CreateInfoBookRequest request) async {
    InfoBookResponse result =
        InfoBookResponse(statusCode: HttpStatus.APP_ERROR);
    final dio = Dio();

    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.getInfoBookApiPath}/${request.id}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response.statusCode != InfoBookResponse.success) {
        return InfoBookResponse(statusCode: response.statusCode ?? 500);
      }
      final dynamic data = response.data;

      List<Map<String, String?>> parseAutor(dynamic autorData) {
        List<Map<String, String?>> autorList = [];

        if (autorData is List) {
          for (var actor in autorData) {
            if (actor is Map<String, dynamic>) {
              String? author = actor['author'];
              String? imageLink = actor['imageLink'];

              if (author != null && imageLink != null) {
                autorList.add({'author': author, 'imageLink': imageLink});
              }
            }
          }
        }
        return autorList;
      }

      result = InfoBookResponse(
          title: data['book']['title'],
          overview: data['book']['overview'],
          posterPath: data['book']['poster_path'],
          backdropPath: data['book']['backdrop_path'],
          releaseDate: data['book']['release_date'],
          voteAverage: data['book']['vote_average'],
          duration: data['book']['duration'],
          authorsPicture: parseAutor(data['book']['authors_picture']),
          statusCode: response.statusCode ?? 500);
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
        return InfoBookResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}
