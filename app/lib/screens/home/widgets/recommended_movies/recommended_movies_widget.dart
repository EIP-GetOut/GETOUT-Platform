/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/widgets/recommended_movies/recommended_movies_success_widget.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';
import 'package:getout/screens/home/bloc/recommended_movies/recommended_movies_bloc.dart';

class RecommendedMoviesWidget extends StatelessWidget {
  const RecommendedMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedMoviesHydratedBloc, RecommendedMoviesState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return RecommendedMoviesSuccessWidget(movies: state.recommendedMovies);
        } else {
          if (state.status.isLoading) {
            return const Center(
                child: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(0, 255, 5, 5))));
          } else if (state.status.isError) {
            return const ObjectLoadingErrorWidget(object: 'les films recommandés');
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
