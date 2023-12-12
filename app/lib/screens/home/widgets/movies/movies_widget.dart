/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/widgets/movies/movies.dart';
import 'package:getout/screens/home/widgets/movies/movies_error_widget.dart';
import 'package:getout/screens/home/bloc/movies/movies_bloc.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MoviesSuccessWidget(movies: state.movies);
        } else {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(0, 255, 5, 5),
            ));
          } else if (state.status.isError) {
            return const MoviesErrorWidget();
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
