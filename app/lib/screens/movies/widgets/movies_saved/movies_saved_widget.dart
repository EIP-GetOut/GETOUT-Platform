/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/movies/widgets/common/movies_error_widget.dart';
import 'package:getout/screens/movies/widgets/movies_saved/movies_saved.dart';
import 'package:getout/screens/movies/bloc/movies_saved/movies_saved_bloc.dart';

class MoviesSavedWidget extends StatelessWidget {
  const MoviesSavedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesSavedBloc, MoviesSavedState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MoviesSavedSuccessWidget(movies: state.moviesSaved);
        } else {
          if (state.status.isLoading) {
            return const Center(child: Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(0, 255, 5, 5))));

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
