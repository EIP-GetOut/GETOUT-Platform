/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/tools/map_box_movie_values_to_ids.dart';

///home_page
import 'package:getout/screens/home/pages/home_page.dart';
import 'package:getout/screens/home/bloc/home_page/home_page_bloc.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';

///movies
import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/bloc/recommended_movies/recommended_movies_bloc.dart';
import 'package:getout/screens/home/bloc/saved_movies/saved_movies_bloc.dart';
import 'package:getout/screens/home/bloc/liked_movies/liked_movies_bloc.dart';

///books
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/recommended_books/recommended_books_bloc.dart';
import 'package:getout/screens/home/bloc/saved_books/saved_books_bloc.dart';
import 'package:getout/screens/home/bloc/liked_books/liked_books_bloc.dart';

//todo - to remove
import 'package:getout/global.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {

    List<int> genreMoviesIds = mapBoxMovieValuesToIds(boxMovieValue);
    List<int> genreBooksIds = mapBoxMovieValuesToIds(boxBookValue);

    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => HomeRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomePageBloc>(
              create: (context) => HomePageBloc(),
            ),
            ///Movies
            BlocProvider<RecommendedMoviesBloc>(
              create: (context) => RecommendedMoviesBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateMoviesRequest(genres: genreMoviesIds),
              ),
            ),
            BlocProvider<LikedMoviesBloc>(
              create: (context) => LikedMoviesBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateMoviesRequest(genres: genreMoviesIds),
              ),
            ),
            BlocProvider<SavedMoviesBloc>(
              create: (context) => SavedMoviesBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateMoviesRequest(genres: genreMoviesIds),
              ),
            ),
            ///Books
            BlocProvider<RecommendedBooksBloc>(
              create: (context) => RecommendedBooksBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateBooksRequest(genres: genreBooksIds),
              ),
            ),
            BlocProvider<LikedBooksBloc>(
              create: (context) => LikedBooksBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateBooksRequest(genres: genreBooksIds),
              ),
            ),
            BlocProvider<SavedBooksBloc>(
              create: (context) => SavedBooksBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateBooksRequest(genres: genreBooksIds),
              ),
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );
  }
}
