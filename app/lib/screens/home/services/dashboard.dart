/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/


part of 'service.dart';



class DashboardService extends ServiceTemplate {
  DashboardService({required this.dio});

  final Dio dio;

  String formatWithGenresParameter(List<int> genres) {
    String withGenres = '';

    for (int genre in genres) {
      withGenres += '$genre,';
    }
    withGenres = withGenres.substring(0, withGenres.length - 1);
    return withGenres;
  }

  Future<GenerateMoviesResponse> getMovies(GenerateMoviesRequest request) async {
    GenerateMoviesResponse result = [];
    dynamic data;

    final dio = Dio();
    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants
            .generateMoviesApiPath}?&include_adult=${request
            .includeAdult.toString()}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching movies: ${response
            .statusMessage}',
      ));
    }

    data = response.data;
    data['movies'].forEach((elem) {
      result.add(MoviePreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${elem['poster']}',
          overview: elem['overview']));
    });
    return result;
  }


  Future<GenerateBooksResponse> getBooks(GenerateBooksRequest request) async {
    GenerateBooksResponse result = [];
    dynamic data;

    final response = await dio.get(
        '${api_constants.rootApiPath}${api_constants
            .generateBooksApiPath}?&include_adult=${request
            .includeAdult.toString()}',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode != HttpStatus.OK) {
      return Future.error(Exception(
        'Error ${response.statusCode} while fetching books: ${response
            .statusMessage}',
      ));
    }

    data = response.data;
    data['books'].forEach((elem) {
      result.add(BookPreview(
          id: elem['id'],
          title: elem['title'],
          posterPath: '${elem['poster']}',
          overview: elem['overview']));
    });
    return result;
  }
}