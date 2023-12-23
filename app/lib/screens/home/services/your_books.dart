/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/


part of 'service.dart';


class YourBooksService extends ServiceTemplate {
  YourBooksService({required this.dio});

  final Dio dio;

  String formatWithGenresParameter(List<int> genres) {
    String withGenres = '';

    for (int genre in genres) {
      withGenres += '$genre,';
    }
    withGenres = withGenres.substring(0, withGenres.length - 1);
    return withGenres;
  }

  /// Like Books
  Future<GetLikeBooksResponse> getLikeBooks(
      GetLikeBooksRequest request) async {
    GetLikeBooksResponse result = [];
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.getLikeBooksApiPath}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching liked books: ${response.statusMessage}',
      ));
    }

    data = response.data;
    data['books'].forEach((elem) {
      result.add(LikeBookPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }

  /// View Books
  Future<GetViewBooksResponse> getViewBooks(
      GetViewBooksRequest request) async {
    GetViewBooksResponse result = [];
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.getViewBooksApiPath}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching viewed books: ${response.statusMessage}',
      ));
    }
    data = response.data;
    data['books'].forEach((elem) {
      result.add(ViewBookPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }

  /// Whislist Books
  Future<GetWishlistBooksResponse> getWishlistBooks(
      GetWishlistBooksRequest request) async {
    GetWishlistBooksResponse result = [];
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants.getWishlistBooksApiPath}',
        options: Options(headers: {'Content-Type': 'application/json'}));
    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching viewed books: ${response.statusMessage}',
      ));
    }
    data = response.data;
    data['books'].forEach((elem) {
      result.add(WishlistBookPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: elem['poster'],
          overview: elem['overview']));
    });
    return result;
  }

}