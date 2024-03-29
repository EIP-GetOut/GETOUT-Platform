/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/


import 'package:dio/dio.dart';

import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/tools/format_with_genres_parameter.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';

part 'dashboard.dart';
part 'books.dart';
part 'movies.dart';

class HomeService extends _HomeService<BooksService, MoviesService> {
  HomeService({required this.dio}) {
    t = BooksService(dio: dio);
    g = MoviesService(dio: dio);
  }
  final Dio dio;

  ///Books
  Future<GenerateBooksResponse> getRecommendedBooks(GenerateBooksRequest request) => t.getRecommendedBooks(request);
  Future<GenerateBooksResponse> getSavedBooks(GenerateBooksRequest request) => t.getSavedBooks(request);
  Future<GenerateBooksResponse> getLikedBooks(GenerateBooksRequest request) => t.getLikedBooks(request);

  ///Movies
  Future<GenerateMoviesResponse> getRecommendedMovies(GenerateMoviesRequest request) => g.getRecommendedMovies(request);
  Future<GenerateMoviesResponse> getSavedMovies(GenerateMoviesRequest request) => g.getSavedMovies(request);
  Future<GenerateMoviesResponse> getLikedMovies(GenerateMoviesRequest request) => g.getLikedMovies(request);
}

abstract class ServiceTemplate {}

class _HomeService<T, G extends ServiceTemplate> {
  late final T t;
  late final G g;
}