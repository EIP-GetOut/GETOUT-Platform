
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/widgets/load_circle.dart';
import 'package:getout/screens/movies/widgets/common/movies_error_widget.dart';
import 'package:getout/screens/movies/widgets/movies_recommanded/movies_recommanded.dart';
import 'package:getout/screens/movies/bloc/movies_recommanded/movies_recommanded_bloc.dart';

class MoviesRecommandedWidget extends StatelessWidget {
  const MoviesRecommandedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesRecommandedBloc, MoviesRecommandedState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MoviesRecommandedSuccessWidget(movies: state.moviesRecommanded);
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
