/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';

import 'package:html/parser.dart'; // pour utiliser parseFragment()

class BookService {
  final Dio dio = Dio();
  final String accountId;

  BookService(String cookiePath, this.accountId) {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});
  }

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

    try {
      final Response response = await dio.get(
          '${ApiConstants.rootApiPath}${ApiConstants.getInfoBookPath}/${request.id}');

      if (response.statusCode != InfoBookResponse.success) {
        return InfoBookResponse(statusCode: response.statusCode ?? 500);
      }

      final dynamic data = response.data;
      result = InfoBookResponse(
          title: response.data['book']['title'],
          overview: parseFragment(response.data['book']['overview']).text ??
              'Pas de description disponible',
          posterPath: response.data['book']['poster_path'],
          backdropPath: response.data['book']['backdrop_path'],
          releaseDate: response.data['book']['release_date'],
          voteAverage: response.data['book']['vote_average'],
          pageCount: response.data['book']['pageCount'] ?? 0,
          bookLink: response.data['book']['book_link'],
          authorsPicture: parseAuthor(data['book']['authors_picture']),
          liked: false, //todo fix globals.session?['likedBooks'].contains(request.id),
          disliked: false, //todo fix globals.session?['dislikedBooks'].contains(request.id),
          wishlisted: false, //todo fix globals.session?['readingList'].contains(request.id),
          read: false, //todo fix globals.session?['readBooks'].contains(request.id),
          id: response.data['book']['id'],
          statusCode: response.statusCode ?? 500);
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddBookResponse> addLikedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final Response response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addLikedBookPath}',
          data: {'bookId': request.id});
      if (response.statusCode != HttpStatus.CREATED) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
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
      final Response response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addLikedBookPath}/${request.id}');
      if (response.statusCode != HttpStatus.OK) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
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
      final Response response = await dio.delete(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addDislikedBookPath}/${request.id}');
      if (response.statusCode != HttpStatus.OK) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
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
      final Response response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.addDislikedBookPath}',
          data: {'bookId': request.id});

      if (response.statusCode != HttpStatus.CREATED) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddBookResponse> addWishlistedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.readingPath}',
          data: {'bookId': request.id});
      if (response.statusCode != HttpStatus.CREATED) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<AddBookResponse> removeWishlistedBook(AddBookRequest request) async {
    AddBookResponse result =
        const AddBookResponse(statusCode: HttpStatus.APP_ERROR);

    try {
      final response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.readingPath}/${request.id}');
      if (response.statusCode != AddBookResponse.success) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this.
      //await globals.sessionManager.getSession();
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
      final response = await dio.post(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.readBooksPath}',
          data: {'bookId': request.id});
      if (response.statusCode != HttpStatus.CREATED) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this
      //await globals.sessionManager.getSession();
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
      final response = await dio.delete(
          '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/$accountId${ApiConstants.readBooksPath}/${request.id}');
      if (response.statusCode != AddBookResponse.success) {
        return AddBookResponse(statusCode: response.statusCode ?? 500);
      }

      result = AddBookResponse(
        statusCode: response.statusCode ?? 500,
      );
      //todo fix this
      //await globals.sessionManager.getSession();
      return result;
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }
}
