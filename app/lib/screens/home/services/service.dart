/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:getout/constants/api_path.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';

part 'dashboard.dart';
part 'books.dart';
part 'movies.dart';

class HomeService extends _HomeService<BooksService, MoviesService> {
  final Dio dio = Dio();

  HomeService(String cookiePath) {
    dio.interceptors.add(CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(cookiePath))));
    dio.options.headers = ({'Content-Type': 'application/json'});

    t = BooksService(dio);
    g = MoviesService(dio);
  }

  ///Books
  Future<GenerateBooksResponse> getRecommendedBooks(GenerateBooksRequest request) => t.getRecommendedBooks(request);
  Future<GenerateBooksResponse> getSavedBooks(GenerateBooksRequest request) => t.getSavedBooks(request);
  Future<GenerateBooksResponse> getLikedBooks(GenerateBooksRequest request) => t.getLikedBooks(request);
  Future<GenerateBooksResponse> getViewedBooks(GenerateBooksRequest request) => t.getViewedBooks(request);

  ///Movies
  Future<GenerateMoviesResponse> getRecommendedMovies(GenerateMoviesRequest request) => g.getRecommendedMovies(request);
  Future<GenerateMoviesResponse> getSavedMovies(GenerateMoviesRequest request) => g.getSavedMovies(request);
  Future<GenerateMoviesResponse> getLikedMovies(GenerateMoviesRequest request) => g.getLikedMovies(request);
  Future<GenerateMoviesResponse> getViewedMovies(GenerateMoviesRequest request) => g.getViewedMovies(request);
}

abstract class ServiceTemplate {}

class _HomeService<T, G extends ServiceTemplate> {
  late final T t;
  late final G g;
}