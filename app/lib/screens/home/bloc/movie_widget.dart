/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/home/pages/loading.dart';

import 'package:getout/screens/home/pages/movies.dart';
import 'package:getout/screens/home/bloc/movie_error_widget.dart';

import 'package:getout/screens/home/bloc/movie_bloc.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MovieState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? MoviesSuccessWidget(
                movies: state.movies,
              )
            : state.status.isLoading
                ? const Center(
                    child: LoadingPage(),
                  )
                : state.status.isError
                    ? const MoviesErrorWidget()
                    : const SizedBox();
      },
    );
  }
}
