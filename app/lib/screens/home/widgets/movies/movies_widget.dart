/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/widgets/load_circle.dart';

import 'package:getout/screens/home/widgets/movies/movies.dart';
import 'package:getout/screens/home/widgets/movies/movies_error_widget.dart';

import 'package:getout/screens/home/bloc/movies/movies_bloc.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? MoviesSuccessWidget(
                movies: state.movies,
              )
            : state.status.isLoading
                ? const Padding(
                    padding: EdgeInsets.only(
                        bottom: 100), //apply padding to all four sides
                    child: Center(child: LoadCirclePage()))
                : state.status.isError
                    ? const MoviesErrorWidget()
                    : const SizedBox();
      },
    );
  }
}
