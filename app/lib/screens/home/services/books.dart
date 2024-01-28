/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class BooksService extends ServiceTemplate {
  final Dio dio;

  BooksService({required this.dio});

  /// RECOMMEND
  Future<GenerateBooksResponse> getRecommendedBooks(
      GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];
    String withGenres = formatWithGenresParameter(request.genres);

    final response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.generateBooksPath}?with_genres=$withGenres&include_adult=${request.includeAdult.toString()}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
      ));
    }

    response.data['books'].forEach((elem) {
      result.add(BookPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
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
        final book = (item as BookPreview);
        result.add(BookPreview(
            id: book.id,
            title: book.title,
            posterPath: book.posterPath,
            overview: book.overview));
      }
    }
    return result;
  }

  Future<dynamic> getLikedBooksId(GenerateBooksRequest request) async {
    final Response response;

    response = await dio.get(
        //Todo A changer avec le account id quand le get session sera fait
        '${ApiConstants.rootApiPath}/account/${ApiConstants.token}/likedBooks',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Cookie': ApiConstants.cookies
        }));
    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
      ));
    }
    return response.data;
  }

  /// SAVED
  Future<GenerateBooksResponse> getSavedBooks(
      GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];

    dynamic data = await getSavedBooksId(request);

    for (String book in data) {
      BookStatusResponse item = await getBookById(book);
      if (item.statusCode == HttpStatus.OK) {
        final book = (item as BookPreview);
        result.add(BookPreview(
            id: book.id,
            title: book.title,
            posterPath: book.posterPath,
            overview: book.overview));
      }
    }
    return result;
  }

  Future<dynamic> getSavedBooksId(GenerateBooksRequest request) async {
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        //Todo - A changer avec le account id quand le get session sera fait + url es ce que c'est bien readinglist le path pour les livres
        '${ApiConstants.rootApiPath}/account/${ApiConstants.token}/readinglist',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Cookie': ApiConstants.cookies
        }));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
      ));
    }

    data = response.data;

    return data;
  }

  //Info
  Future<BookStatusResponse> getBookById(String book) async {
    BookStatusResponse result =
        const BookStatusResponse(statusCode: HttpStatus.APP_ERROR);
    final dio = Dio();

    final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoMoviePath}/$book',
        options: Options(headers: {'Content-Type': 'application/json'}));
    try {
      if (response.statusCode != MovieStatusResponse.success) {
        return const BookStatusResponse(statusCode: HttpStatus.INTERNAL_SERVER_ERROR);
      }
      final dynamic data = response.data;
      result = BookStatusResponse(
          title: data['book']['title'],
          overview:
              data['book']['overview'] ?? 'Pas de description disponible',
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
