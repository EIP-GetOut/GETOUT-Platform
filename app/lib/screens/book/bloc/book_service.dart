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

import 'package:html/parser.dart'; // pour utiliser parseFragment()

class BookService {
  final String userId = globals.session?['id'].toString() ?? '';

  PersonList parseAuthor(final castData) {
    print("dans parseAuhtors");
    PersonList castList = [];
    print(castData);
    for (final author in castData) {
      String? name = author ?? '';
      String picture = 'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg';

      if (name != null) {
        castList.add(Person(name: name, picture: picture));
      }
      print(castList);
    }

    print(castList);
    return castList;
  }

  Future<InfoBookResponse> getInfoBook(CreateInfoBookRequest request) async {
    InfoBookResponse result =
        const InfoBookResponse(statusCode: HttpStatus.APP_ERROR);
print("dans get info book");
    final response = await globals.dio?.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoBookPath}/${request.id}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response?.statusCode != InfoBookResponse.success) {
        return InfoBookResponse(statusCode: response?.statusCode ?? 500);
      }

      final dynamic data = response?.data;
      // print('DATA ====== ');
      // print(data);
      result = InfoBookResponse(
          title: data['title'] ?? 'Aucun titre',
          overview: data['description'] != null ? parseFragment(data['description']).text :
              'Pas de description disponible',
          posterPath: data['posterPath'] ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgijoe.fandom.com%2Fwiki%2FVoid_Rivals_TPB_02&psig=AOvVaw3WPQ4SmYRlwda4umtwa8I0&ust=1723725563604000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJjmlaPA9IcDFQAAAAAdAAAAABAE',
          backdropPath: data['backdropPath'] ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgijoe.fandom.com%2Fwiki%2FVoid_Rivals_TPB_02&psig=AOvVaw3WPQ4SmYRlwda4umtwa8I0&ust=1723725563604000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJjmlaPA9IcDFQAAAAAdAAAAABAE',
          releaseDate: data['releaseDate'] ?? 'Pas de date',
          voteAverage: data['averageRating'] ?? 0,
          pageCount: data['pageCount'] ?? 0,
          bookLink: data['link'] ?? '',
          authorsPicture: parseAuthor(data['authors']),
          liked: globals.session?['likedBooks'].toString().contains(request.id.toString()),
          disliked: globals.session?['dislikedBooks'].toString().contains(request.id.toString()),
          wishlisted: globals.session?['readingList'].toString().contains(request.id.toString()),
          read: globals.session?['readBooks'].toString().contains(request.id.toString()),
          id: data['id'],
          statusCode: response?.statusCode ?? 500);
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      print('dioError');
      print(dioError);
      rethrow;
    }
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

  Future<AddBookResponse> addWishListedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readingPath}',
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

  Future<AddBookResponse> removeWishListedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readingPath}/${request.id}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));
      if (response?.statusCode != AddBookResponse.success) {
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

  Future<AddBookResponse> addReadBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readBooksPath}',
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

  Future<AddBookResponse> removeReadBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await globals.dio?.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readBooksPath}/${request.id}',
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ));
      if (response?.statusCode != AddBookResponse.success) {
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
}
