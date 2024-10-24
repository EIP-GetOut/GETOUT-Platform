/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:html/parser.dart'; // pour utiliser parseFragment()
import 'package:dio/dio.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/global.dart' as globals;

class BookService {
  final String userId = globals.session?['id'].toString() ?? '';
  final Dio dio = Dio(globals.dioOptions);

  BookService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
  }

  PersonList parseAuthor(final castData) {
    PersonList castList = [];
    for (final author in castData) {
      String? name = author ?? 'Auteur inconnu';
      String picture =
          'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg';

      if (name != null) {
        castList.add(Person(name: name, picture: picture));
      }
    }

    return castList;
  }

  Future<InfoBookResponse> getInfoBook(CreateInfoBookRequest request) async {
    InfoBookResponse result =
        const InfoBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoBookPath}/${request
            .id}',
      );

      final dynamic data = response.data;
      result = InfoBookResponse(
          title: data['title'] ?? 'Aucun titre',
          overview: data['description'] != null
              ? parseFragment(data['description']).text
              : 'Pas de description disponible',
          posterPath: data['posterPath'] ??
              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgijoe.fandom.com%2Fwiki%2FVoid_Rivals_TPB_02&psig=AOvVaw3WPQ4SmYRlwda4umtwa8I0&ust=1723725563604000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJjmlaPA9IcDFQAAAAAdAAAAABAE',
          backdropPath: data['backdropPath'] ??
              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgijoe.fandom.com%2Fwiki%2FVoid_Rivals_TPB_02&psig=AOvVaw3WPQ4SmYRlwda4umtwa8I0&ust=1723725563604000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJjmlaPA9IcDFQAAAAAdAAAAABAE',
          releaseDate: data['releaseDate'] ?? 'Pas de date',
          voteAverage: data['averageRating'],
          pageCount: data['pageCount'] ?? 0,
          bookLink: data['link'] ?? '',
          genres: data['categories'] ?? [],
          authorsPicture: parseAuthor(data['authors']),
          liked: globals.session?['likedBooks']
              .toString()
              .contains(request.id.toString()),
          disliked: globals.session?['dislikedBooks']
              .toString()
              .contains(request.id.toString()),
          wishlisted: globals.session?['readingList']
              .toString()
              .contains(request.id.toString()),
          read: globals.session?['readBooks']
              .toString()
              .contains(request.id.toString()),
          id: data['id'],
          statusCode: response.statusCode ?? HttpStatus.APP_ERROR);
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return InfoBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return InfoBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> addLikedBook(AddBookRequest request) async {
    AddBookResponse result =
    const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants
              .accountPath}/$userId${ApiConstants.addLikedBookPath}',
          data: {'bookId': request.id});

      result = AddBookResponse(
          statusCode: response.statusCode ?? HttpStatus.APP_ERROR);

      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> removeLikedBook(AddBookRequest request) async {
    AddBookResponse result =
    const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants
            .accountPath}/$userId${ApiConstants.addLikedBookPath}/${request
            .id}',
      );
      result = AddBookResponse(
          statusCode: response.statusCode ?? HttpStatus.APP_ERROR);
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> removeDislikedBook(AddBookRequest request) async {
    AddBookResponse result =
    const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedBookPath}/${request.id}',
      );
      result = AddBookResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );

      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> addDislikedBook(AddBookRequest request) async {
    AddBookResponse result =
    const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.addDislikedBookPath}',
          data: {
            'bookId': request.id
          });
      result = AddBookResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR);
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> addWishListedBook(AddBookRequest request) async {
    AddBookResponse result =
    const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readingPath}',
          data: {
            'bookId': request.id
          });
      result = AddBookResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR,
      );
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> removeWishListedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readingPath}/${request.id}',
      );
      result = AddBookResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR);
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> addReadBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readBooksPath}',
          data: {
            'bookId': request.id
          });
      result = AddBookResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR);
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }

  Future<AddBookResponse> removeReadBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$userId${ApiConstants.readBooksPath}/${request.id}',
      );
      result = AddBookResponse(
        statusCode: response.statusCode ?? HttpStatus.APP_ERROR);
      await globals.sessionManager.getSession();
    } on DioException catch (dioException) {
      if (dioException.type == DioExceptionType.connectionTimeout ||
          dioException.type == DioExceptionType.receiveTimeout ||
          dioException.type == DioExceptionType.sendTimeout) {
        return AddBookResponse(statusCode: HttpStatus.APP_TIMEOUT);
      } else if (dioException.response == null ||
          dioException.response!.statusCode == null) {
        return result;
      } else {
        return AddBookResponse(statusCode: dioException.response!.statusCode!);
      }
    } catch (error) {
      return result;
    }
    return result;
  }
}
