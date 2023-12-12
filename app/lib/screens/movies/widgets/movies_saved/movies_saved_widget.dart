
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/widgets/load_circle.dart';
import 'package:getout/screens/movies/widgets/common/movies_error_widget.dart';
import 'package:getout/screens/movies/widgets/movies_saved/movies_saved.dart';
import 'package:getout/screens/movies/bloc/movies_saved/movies_saved_bloc.dart';

class MoviesSavedWidget extends StatelessWidget {
  const MoviesSavedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesSavedBloc, MoviesSavedState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MoviesSavedSuccessWidget(movies: state.moviesSaved);
        } else {
          if (state.status.isLoading) {
            return const Center(child: LoadCirclePage());
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
