/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class BooksService extends ServiceTemplate {
  final String _id = (globals.session != null) ? globals.session!['id'].toString() : '';
  final Dio dio = Dio(globals.dioOptions);

  BooksService() {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(globals.cookiePath))));
  }

  /// RECOMMENDED
  Future<GenerateBooksResponse> getRecommendedBooks(
      GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];

    try { /// TODO we need to do something prettier
      final response = await dio.get(
          '${ApiConstants.rootApiPath}/account/$_id${ApiConstants.recommendedBooksPath}',
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
        ));
      }
      response.data.forEach((elem) {
       List<dynamic>? genres = elem['categories']?.toString().replaceAll('[', '').replaceAll(']', '').split(',');
       if (genres!= null && genres.length > 2) genres = genres.sublist(0, 2);
        result.add(BookPreview(
            id: elem['id'],
            title: elem['title'],
            posterPath: elem['posterPath'],
            overview: elem['description'],
            releaseDate: elem['releaseDate'],
            averageRating: elem['averageRating'],
            genres: genres));
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
    /// TODO need to be put in a try catch
    final Response response =
    await dio.get('${ApiConstants.rootApiPath}/account/$_id/likedBooks');
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
    /// TODO need to be put in a try catch
    final response = await dio
        .get('${ApiConstants.rootApiPath}/account/$_id/readinglist');

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response.statusMessage}',
      ));
    }
    return response.data;
  }

  /// WATCHED
  Future<GenerateBooksResponse> getWatchedBooks(
      GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];

    dynamic data = await getWatchedBooksId(request);

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

  Future<dynamic> getWatchedBooksId(GenerateBooksRequest request) async {
    /// TODO need to be put in a try catch
    final response = await dio
        .get('${ApiConstants.rootApiPath}/account/$_id/readBooks');
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

    /// TODO need to be put in a try catch
    final Response response = await dio.get(
        '${ApiConstants.rootApiPath}${ApiConstants.getInfoBookPath}/$book');
    try {
      if (response.statusCode != MovieStatusResponse.success) {
        return const BookStatusResponse(
            statusCode: HttpStatus.INTERNAL_SERVER_ERROR);
      }
      final dynamic data = response.data;
      result = BookStatusResponse(
          title: data['title'] ?? 'Titre inconnue',
          overview: data['description'] ?? 'Pas de description disponible',
          posterPath: data['posterPath'] ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgijoe.fandom.com%2Fwiki%2FVoid_Rivals_TPB_02&psig=AOvVaw2skAKZpPM9bWFhXo9mQQOV&ust=1723799097653000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJCb5JjS9ocDFQAAAAAdAAAAABAE',
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
