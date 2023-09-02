import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/screens/movie/pages/movie.dart';
import 'package:getout/screens/home/widgets/movies/movies_error_widget.dart';
import 'package:getout/widgets/loading.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? MovieSuccessWidget(
                movie: state.movie,
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
