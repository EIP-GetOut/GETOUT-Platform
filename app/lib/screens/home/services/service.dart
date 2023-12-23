/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:getout/constants/api_path.dart' as api_constants;
import 'package:getout/constants/http_status.dart';

/**
 * dashboard:
 */
import 'package:getout/screens/home/children/dashboard/bloc/movies/movies_bloc.dart';
import 'package:getout/screens/home/children/dashboard/bloc/books/books_bloc.dart';

/**
 * your_books:
 */
import 'package:getout/screens/home/children/your_books/bloc/like_books/like_books_bloc.dart';
import 'package:getout/screens/home/children/your_books/bloc/view_books/view_books_bloc.dart';
import 'package:getout/screens/home/children/your_books/bloc/wishlist_books/wishlist_books_bloc.dart';

/**
 * parts:
 */
part 'dashboard.dart';
part 'your_books.dart';

class HomeService extends _HomeService<DashboardService, YourBooksService> {
  HomeService({required this.dio}) {
    t = DashboardService(dio: dio);
    g = YourBooksService(dio: dio);
  }
  final Dio dio;

  //Dashboard
  Future<GenerateMoviesResponse> getMovies(GenerateMoviesRequest request) => t.getMovies(request);
  Future<GenerateBooksResponse> getBooks(GenerateBooksRequest request) => t.getBooks(request);
  //Your_books
  Future<GetWishlistBooksResponse> getWishlistBooks(GetWishlistBooksRequest request) => g.getWishlistBooks(request);
  Future<GetViewBooksResponse> getViewBooks(GetViewBooksRequest request) => g.getViewBooks(request);
  Future<GetLikeBooksResponse> getLikeBooks(GetLikeBooksRequest request) => g.getLikeBooks(request);
  Future<GenerateBooksResponse> getSuggestionBooks(GenerateBooksRequest request) => t.getBooks(request);
}

abstract class ServiceTemplate {}

class _HomeService<T, G extends ServiceTemplate> {
  late final T t;
  late final G g;
}