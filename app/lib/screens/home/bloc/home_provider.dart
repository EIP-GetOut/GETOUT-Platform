/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/children/dashboard/bloc/movies/movies_bloc.dart';
import 'package:getout/screens/home/children/dashboard/bloc/books/books_bloc.dart';
import 'package:getout/screens/home/bloc/home_page_bloc.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';
import 'package:getout/screens/home/pages/home_page.dart';
import 'package:getout/screens/home/services/service.dart';
import 'package:getout/tools/map_box_movie_values_to_ids.dart';
//to remove
import 'package:getout/global.dart';

//ignore: must_be_immutable
class HomeProvider extends StatelessWidget {
  HomeProvider({super.key});

  List<int> genreMoviesIds = mapBoxMovieValuesToIds(boxMovieValue);
  List<int> genreBooksIds = mapBoxMovieValuesToIds(boxBookValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => HomeRepository(service: HomeService(dio: Dio())),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomePageBloc>(
              create: (context) => HomePageBloc(),
            ),
            BlocProvider<MoviesBloc>(
              create: (context) => MoviesBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateMoviesRequest(genres: genreMoviesIds),
              ),
            ),
            BlocProvider<BooksBloc>(
              create: (context) => BooksBloc(
                homeRepository: context.read<HomeRepository>(),
              )..add(
                GenerateBooksRequest(genres: genreBooksIds),
              ),
            ),
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}
