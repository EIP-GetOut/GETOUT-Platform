/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau  <ines.maaroufi@epitech.eu>
*/

import 'package:getout/screens/home/children/your_books/bloc/like_books/like_books_bloc.dart';
import 'package:getout/screens/home/children/your_books/bloc/view_books/view_books_bloc.dart';
import 'package:getout/screens/home/children/your_books/bloc/wishlist_books/wishlist_books_bloc.dart';
import 'package:getout/screens/home/services/service.dart';
import 'package:getout/screens/home/children/dashboard/bloc/movies/movies_bloc.dart';
import 'package:getout/screens/home/children/dashboard/bloc/books/books_bloc.dart';

class HomeRepository {
  const HomeRepository({
    required this.service,
  });

  final HomeService service;

  Future<GenerateMoviesResponse> getMovies(
          GenerateMoviesRequest request) async =>
      service.getMovies(request);

  Future<GenerateBooksResponse> getBooks(GenerateBooksRequest request) async =>
      service.getBooks(request);

  Future<GenerateBooksResponse> getSuggestionBooks(GenerateBooksRequest request) async =>
      service.getSuggestionBooks(request);

  Future<GetLikeBooksResponse> getLikeBooks(GetLikeBooksRequest request) async =>
      service.getLikeBooks(request);

  Future<GetViewBooksResponse> getViewBooks(GetViewBooksRequest request) async =>
      service.getViewBooks(request);

  Future<GetWishlistBooksResponse> getWishlistBooks(GetWishlistBooksRequest request) async =>
      service.getWishlistBooks(request);
}
