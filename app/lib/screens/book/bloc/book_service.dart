/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';

import 'package:getout/global.dart' as globals;

class BookService {
  Future<InfoBookResponse> getInfoBook(CreateInfoBookRequest request) async {
    InfoBookResponse result =
        const InfoBookResponse(statusCode: HttpStatus.APP_ERROR);

    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoBookPath}/${request.id}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response?.statusCode != InfoBookResponse.success) {
        return InfoBookResponse(statusCode: response?.statusCode ?? 500);
      }
      final dynamic data = response?.data;

      List<Map<String, String?>> parseAutor(dynamic autorData) {
        List<Map<String, String?>> autorList = [];

        if (autorData is List) {
          for (var actor in autorData) {
            if (actor is Map<String, dynamic>) {
              String? author = json.encode(actor['author']);
              String? imageLink = json.encode(actor['imageLink']);

              if (author != null && imageLink != null) {
                autorList.add({'author': author, 'imageLink': imageLink});
              } else if (author != null && imageLink == null) {
                autorList.add({
                  'author': author,
                  'imageLink':
                      'https://upload.wikimedia.org/wikipedia/commons/0/0f/Blank_Square.svg'
                });
              }
            }
          }
        }
        return autorList;
      }

      final bool isOverviewEmpty = (response?.data['book']['overview'] == '');
      final bool isDurationEmpty =
          (response?.data['book']['duration'] == '0h0min');

      result = InfoBookResponse(
          title: response?.data['book']['title'],
          overview: isOverviewEmpty
              ? response?.data['book']['overview']
              : 'Pas de description disponible',
          posterPath: response?.data['book']['poster_path'],
          backdropPath: response?.data['book']['backdrop_path'],
          releaseDate: response?.data['book']['release_date'],
          voteAverage: response?.data['book']['vote_average'],
          duration: isDurationEmpty ? response?.data['book']['duration'] : 'N/A',
          authorsPicture: parseAutor(data['book']['authorsPicture']),
          statusCode: response?.statusCode ?? 500);
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
