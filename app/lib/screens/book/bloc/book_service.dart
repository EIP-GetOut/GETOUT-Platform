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

import 'package:getout/global.dart' as globals;

class BookService {
  final String userId = globals.session?['id'].toString() ?? '';

  PersonList parseAuthor(final castData) {
    PersonList castList = [];

        for (final author in castData) {
          String? name = author['author'];
          String picture = author['picture'] ??
              'https://t3.ftcdn.net/jpg/05/03/24/40/360_F_503244059_fRjgerSXBfOYZqTpei4oqyEpQrhbpOML.jpg';

          if (name != null) {
            castList.add(Person(name: name, picture: picture));
          }
        }

    return castList;
  }

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

      result = InfoBookResponse(
          title: response?.data['book']['title'],
          overview: response?.data['book']['overview'] ??
              'Pas de description disponible',
          posterPath: response?.data['book']['poster_path'],
          backdropPath: response?.data['book']['backdrop_path'],
          releaseDate: response?.data['book']['release_date'],
          voteAverage: response?.data['book']['vote_average'],
          pageCount: response?.data['book']['pageCount'] ?? 0,
          authorsPicture: parseAuthor(data['book']['authors_picture']),
          liked: globals.session?['likedBooks'].contains(request.id),
          disliked: globals.session?['dislikedBooks'].contains(request.id),
          id: response?.data['book']['id'],
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

  Future<AddBookResponse> addLikedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addLikedBookPath}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: {'bookId': request.id});
      if (response?.statusCode != HttpStatus.CREATED) {
        return AddBookResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddBookResponse(
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

  Future<AddBookResponse> removeLikedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addLikedBookPath}/${request.id}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response?.statusCode != HttpStatus.OK) {
        return AddBookResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddBookResponse(
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

  Future<AddBookResponse> removeDislikedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedBookPath}/${request.id}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response?.statusCode != HttpStatus.OK) {
        return AddBookResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddBookResponse(
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

  Future<AddBookResponse> addDislikedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedBookPath}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: {'bookId': request.id});

      if (response?.statusCode != HttpStatus.CREATED) {
        return AddBookResponse(statusCode: response?.statusCode ?? 500);
      }

      result = AddBookResponse(
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
}
