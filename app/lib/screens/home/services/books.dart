/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class BooksService extends ServiceTemplate {
  final Dio dio;

  BooksService(this.dio);

  /// RECOMMEND
  Future<GenerateBooksResponse> getRecommendedBooks(
      GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];

    try { /// TODO we need to do something prettier
      final response = await dio.get(
          '${ApiConstants.rootApiPath}/account/${request.accountId}${ApiConstants.recommendedBooksPath}');

      if (response.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
        ));
      }

      response.data.forEach((elem) {
        result.add(BookPreview(
            id: elem['id'],
            title: elem['title'],
            posterPath: elem['poster_path'],
            overview: elem['overview']));
      });
    } on DioException catch (dioException) {
      if (dioException.response != null && dioException.response?.statusCode != null) {
        return Future.error(Exception(
          'Error ${dioException.response?.statusCode} while fetching books: ${dioException.response?.statusMessage}',
        ));
      }
      return Future.error(Exception(
          'Unknown error:  ${dioException.toString()}'));
    } catch (error) {
      return Future.error(Exception(
        'Unknown error: ${error.toString()}',
      ));
    }
    return result;
  }

  /// LIKED
  Future<GenerateBooksResponse> getLikedBooks(
      GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];

    dynamic data = await getLikedBooksId(request);

    for (String book in data) {
      BookStatusResponse item = await getBookById(book);
      if (item.statusCode == HttpStatus.OK) {
        result.add(BookPreview(
            id: item.id!,
            title: item.title!,
            posterPath: item.posterPath,
            overview: item.overview));
      }
    }
    return result;
  }

  Future<dynamic> getLikedBooksId(GenerateBooksRequest request) async {

    final Response response = await dio.get('${ApiConstants.rootApiPath}/account/${request.accountId}/likedBooks');
    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
      ));
    }
    return response.data;
  }

  /// SAVED
  Future<GenerateBooksResponse> getSavedBooks(GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];

    final dynamic data = await getSavedBooksId(request);

    for (String book in data) {
      BookStatusResponse item = await getBookById(book);
      if (item.statusCode == HttpStatus.OK) {
        result.add(BookPreview(
            id: item.id!,
            title: item.title!,
            posterPath: item.posterPath,
            overview: item.overview));
      }
    }
    return result;
  }

  Future<dynamic> getSavedBooksId(GenerateBooksRequest request) async {
    final response = await dio.get('${ApiConstants.rootApiPath}/account/${request.accountId}/readinglist');

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
      ));
    }
    return response.data;
  }

  /// VIEWED
  Future<GenerateBooksResponse> getViewedBooks(GenerateBooksRequest request) async {
    final GenerateBooksResponse result = [];

    final dynamic data = await getViewedBooksId(request);

    for (String book in data) {
      BookStatusResponse item = await getBookById(book);
      if (item.statusCode == HttpStatus.OK) {
        result.add(BookPreview(
            id: item.id!,
            title: item.title!,
            posterPath: item.posterPath,
            overview: item.overview));
      }
    }
    return result;
  }

  Future<dynamic> getViewedBooksId(GenerateBooksRequest request) async {
    final response = await dio.get('${ApiConstants.rootApiPath}/account/${request.accountId}/readBooks');

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
      ));
    }

    return response.data;
  }

  //Info
  Future<BookStatusResponse> getBookById(String book) async {
    BookStatusResponse result =
        const BookStatusResponse(statusCode: HttpStatus.APP_ERROR);

    final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoBookPath}/$book');
    try {
      if (response.statusCode != MovieStatusResponse.success) {
        return const BookStatusResponse(
            statusCode: HttpStatus.INTERNAL_SERVER_ERROR);
      }
      final dynamic data = response.data;
      result = BookStatusResponse(
          title: data['book']['title'],
          overview: data['book']['overview'] ?? 'Pas de description disponible',
          posterPath: data['book']['poster_path'],
          id: book,
          statusCode: response.statusCode ?? HttpStatus.INTERNAL_SERVER_ERROR);
    } catch (error) {
      if (error.toString() == 'Connection reset by peer' ||
          error.toString() ==
              'Connection closed before full header was received') {
        return const BookStatusResponse(statusCode: HttpStatus.NO_INTERNET);
      }
      return result;
    }
    return result;
  }
}
