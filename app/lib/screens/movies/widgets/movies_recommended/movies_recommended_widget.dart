/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/movies/widgets/common/movies_error_widget.dart';
import 'package:getout/screens/movies/widgets/movies_recommended/movies_recommended.dart';
import 'package:getout/screens/movies/bloc/movies_recommended/movies_recommended_bloc.dart';

class MoviesRecommendedWidget extends StatelessWidget {
  const MoviesRecommendedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesRecommendedBloc, MoviesRecommendedState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MoviesRecommendedSuccessWidget(movies: state.moviesRecommended);
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
