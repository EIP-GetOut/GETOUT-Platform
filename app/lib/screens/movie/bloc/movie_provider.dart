/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/screens/movie/bloc/movie_service.dart';
import 'package:getout/screens/movie/widgets/movie_widget.dart';

class Movie extends StatelessWidget {
  const Movie(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => MovieService(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MovieBloc>(
              create: (context) => MovieBloc(
                movieService: context.read<MovieService>(),
              )..add(
                  CreateInfoMovieRequest(id: id),
                ),
            ),
          ],
          child: const MovieWidget(),
        ),
      ),
    );
  }
}
