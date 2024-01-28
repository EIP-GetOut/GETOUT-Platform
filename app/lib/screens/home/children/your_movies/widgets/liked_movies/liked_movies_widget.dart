/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';
import 'package:getout/screens/home/children/your_movies/widgets/liked_movies/liked_movies_success_widget.dart';
import 'package:getout/screens/home/bloc/liked_movies/liked_movies_bloc.dart';

class LikedMoviesWidget extends StatelessWidget {
  const LikedMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedMoviesBloc, LikedMoviesState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return LikedMoviesSuccessWidget(movies: state.likedMovies);
        } else {
          if (state.status.isLoading) {
            return const Center(child: Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(0, 255, 5, 5))));

          } else if (state.status.isError) {
            return const ObjectLoadingErrorWidget(object: 'les films aimés');
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}