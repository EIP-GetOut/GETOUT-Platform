import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/tools/app_l10n.dart';

import 'package:getout/widgets/object_loading_error_widget.dart';
import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/screens/movie/pages/movie.dart';
import 'package:getout/widgets/loading.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MovieSuccessWidget(movie: state.movie);
        } else {
          if (state.status.isLoading) {
            return const Center(child: LoadingPage());
          } else if (state.status.isError) {
            return ObjectLoadingErrorWidget(object: appL10n(context)!.the_movie.toLowerCase());
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
