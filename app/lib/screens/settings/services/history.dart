/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class HistoryService extends ServiceTemplate {
  final String _id = (globals.session != null) ? globals.session!['id'].toString() : '';
  HistoryService();

  Future<HistoryBooksResponse> getHistoryBooks() async {
    HistoryBooksResponse result = [];
    try { /// TODO we need to do something prettier
      final response = await globals.dio?.get(
          '${ApiConstants.rootApiPath}/account/$_id${ApiConstants.recommendedBooksHistoryPath}',
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response?.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response?.statusCode} while fetching books: ${response?.statusMessage}',
        ));
      }

      response?.data.forEach((elem) {
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


  Future<HistoryMoviesResponse> getHistoryMovies() async {
    HistoryMoviesResponse result = [];

    try { /// TODO we need to do something prettier
      final response = await globals.dio?.get(
          '${ApiConstants.rootApiPath}/account/$_id${ApiConstants.recommendedMoviesHistoryPath}',
          options: Options(headers: {'Content-Type': 'application/json'}));
      if (response?.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response?.statusCode} while fetching books: ${response?.statusMessage}',
        ));
      }
      response?.data.forEach((elem) {
        result.add(MoviePreview(
            id: elem['id'],
            title: elem['title'],
            posterPath: elem['poster_path'],
            overview: elem['overview']));
      });
    } on DioException catch (dioException) {
      if (dioException.response != null && dioException.response?.statusCode != null) {
        return Future.error(Exception(
          'Error ${dioException.response?.statusCode} while fetching movies: ${dioException.response?.statusMessage}',
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
}