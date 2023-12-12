/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/movies/pages/movies.dart';
import 'package:getout/screens/movies/bloc/movies/movies_service.dart';
import 'package:getout/screens/movies/bloc/movies/movies_repository.dart';
import 'package:getout/screens/movies/bloc/movies_liked/movies_liked_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_recommanded/movies_recommanded_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_saved/movies_saved_bloc.dart';
import 'package:getout/global.dart';
import 'package:getout/tools/map_box_movie_values_to_ids.dart';

//ignore: must_be_immutable
class Movies extends StatelessWidget {
  Movies({Key? key}) : super(key: key);

  List<int> genreMoviesIds = mapBoxMovieValuesToIds(boxMovieValue);
  List<int> genreBooksIds = mapBoxMovieValuesToIds(boxBookValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => MoviesRepository(service: MoviesService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MoviesLikedBloc>(
              create: (context) => MoviesLikedBloc(
                moviesRepository: context.read<MoviesRepository>(),
              )..add(
                  GenerateMoviesLikedRequest(genres: genreMoviesIds),
                ),
            ),
            BlocProvider<MoviesRecommandedBloc>(
              create: (context) => MoviesRecommandedBloc(
                moviesRepository: context.read<MoviesRepository>(),
              )..add(
                  GenerateMoviesRecommandedRequest(genres: genreMoviesIds),
                ),
            ),
            BlocProvider<MoviesSavedBloc>(
              create: (context) => MoviesSavedBloc(
                moviesRepository: context.read<MoviesRepository>(),
              )..add(
                  GenerateMoviesSavedRequest(genres: genreMoviesIds),
                ),
            ),
          ],
          child: const MoviesLayout(),
        ),
      ),
    );
  }
}
