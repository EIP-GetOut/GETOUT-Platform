/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

///home_page
import 'package:getout/screens/home/home_page.dart';
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

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(create: (context) => HomeRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomePageBloc>(
              create: (context) => HomePageBloc(),
            ),
            ///Movies
            BlocProvider<RecommendedMoviesHydratedBloc>(
              create: (context) => RecommendedMoviesHydratedBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                const GenerateMoviesRequest(),
              ),
            ),
            BlocProvider<LikedMoviesHydratedBloc>(
              create: (context) => LikedMoviesHydratedBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                const GenerateMoviesRequest(),
              ),
            ),
            BlocProvider<SavedMoviesHydratedBloc>(
              create: (context) => SavedMoviesHydratedBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                const GenerateMoviesRequest(),
              ),
            ),
            ///Books
            BlocProvider<RecommendedBooksHydratedBloc>(
              create: (context) => RecommendedBooksHydratedBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                const GenerateBooksRequest(),
              ),
            ),
            BlocProvider<LikedBooksHydratedBloc>(
              create: (context) => LikedBooksHydratedBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                const GenerateBooksRequest(),
              ),
            ),
            BlocProvider<SavedBooksHydratedBloc>(
              create: (context) => SavedBooksHydratedBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                const GenerateBooksRequest(),
              ),
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );
  }
}
