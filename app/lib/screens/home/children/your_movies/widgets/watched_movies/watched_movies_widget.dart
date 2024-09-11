/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/watched_movies/watched_movies_bloc.dart';
import 'package:getout/screens/home/children/your_movies/widgets/watched_movies/watched_movies_success_widget.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';

class WatchedMoviesWidget extends StatelessWidget {
  const WatchedMoviesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchedMoviesHydratedBloc, WatchedMoviesState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return WatchedMoviesSuccessWidget(movies: state.watchedMovies);
        } else {
          if (state.status.isLoading) {
            return const Center(child: Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(0, 255, 5, 5))));

          } else if (state.status.isError) {
            return ObjectLoadingErrorWidget(object: appL10n(context)!.liked_movies);
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}