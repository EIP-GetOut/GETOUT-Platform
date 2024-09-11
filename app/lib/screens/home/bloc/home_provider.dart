/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/home/bloc/watched_books/watched_books_bloc.dart';
import 'package:getout/screens/home/bloc/watched_movies/watched_movies_bloc.dart';

///home
import 'package:getout/screens/home/services/service.dart';

///home_page
import 'package:getout/screens/home/home_page.dart';
import 'package:getout/screens/home/bloc/home_page/home_page_bloc.dart';

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

import 'package:getout/screens/home/widgets/dashboard/story_news/story_news_bloc.dart';
import 'package:getout/screens/home/widgets/dashboard/news/news_bloc.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => HomeService(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomePageBloc>(
              create: (context) => HomePageBloc(),
            ),

            ///Movies
            BlocProvider<RecommendedMoviesHydratedBloc>(
              lazy: false,
              create: (context) => RecommendedMoviesHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const GenerateMoviesRequest(),
                ),
            ),
            BlocProvider<LikedMoviesHydratedBloc>(
              lazy: false,
              create: (context) => LikedMoviesHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const GenerateMoviesRequest(),
                ),
            ),
            BlocProvider<SavedMoviesHydratedBloc>(
              lazy: false,
              create: (context) => SavedMoviesHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const GenerateMoviesRequest(),
                ),
            ),
            BlocProvider<WatchedMoviesHydratedBloc>(
              lazy: false,
              create: (context) => WatchedMoviesHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                const GenerateMoviesRequest(),
              ),
            ),

            ///Books
            BlocProvider<RecommendedBooksHydratedBloc>(
              lazy: false,
              create: (context) => RecommendedBooksHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const GenerateBooksRequest(),
                ),
            ),
            BlocProvider<LikedBooksHydratedBloc>(
              lazy: false,
              create: (context) => LikedBooksHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const GenerateBooksRequest(),
                ),
            ),
            BlocProvider<SavedBooksHydratedBloc>(
              lazy: false,
              create: (context) => SavedBooksHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const GenerateBooksRequest(),
                ),
            ),
            BlocProvider<WatchedBooksHydratedBloc>(
              lazy: false,
              create: (context) => WatchedBooksHydratedBloc(
                homeService: context.read<HomeService>(),
              )..add(
                const GenerateBooksRequest(),
              ),
            ),
            ///Dashboard
            BlocProvider<StoryNewsBloc>(
              lazy: false,
              create: (context) => StoryNewsBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const StoryNewsRequest(),
                ),
            ),
            BlocProvider<NewsBloc>(
              lazy: false,
              create: (context) => NewsBloc(
                homeService: context.read<HomeService>(),
              )..add(
                  const NewsRequest(),
                ),
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );
  }
}
