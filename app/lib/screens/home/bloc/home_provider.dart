/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/bloc/user/user_bloc.dart';

///home
import 'package:getout/screens/home/services/service.dart';

///home_page
import 'package:getout/screens/home/home_page.dart';

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
  Widget build(BuildContext context) {
    UserState user = context.watch<UserBloc>().state;
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => HomeService(user.cookiePath),
        child: MultiBlocProvider(
          providers: [
            ///Movies
            BlocProvider<RecommendedMoviesHydratedBloc>(
              create: (context) => RecommendedMoviesHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(GenerateMoviesRequest(user.account!.id)),
            ),
            BlocProvider<LikedMoviesHydratedBloc>(
              create: (context) => LikedMoviesHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(GenerateMoviesRequest(user.account!.id)),
            ),
            BlocProvider<SavedMoviesHydratedBloc>(
              create: (context) => SavedMoviesHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(GenerateMoviesRequest(user.account!.id)),
            ),

            ///Books
            BlocProvider<RecommendedBooksHydratedBloc>(
              create: (context) => RecommendedBooksHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(GenerateBooksRequest(user.account!.id)),
            ),
            BlocProvider<LikedBooksHydratedBloc>(
              create: (context) => LikedBooksHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(GenerateBooksRequest(user.account!.id)),
            ),
            BlocProvider<SavedBooksHydratedBloc>(
              create: (context) => SavedBooksHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(GenerateBooksRequest(user.account!.id)),
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );
  }
}
