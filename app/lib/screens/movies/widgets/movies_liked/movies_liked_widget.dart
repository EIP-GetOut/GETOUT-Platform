
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/widgets/load_circle.dart';
import 'package:getout/screens/movies/widgets/common/movies_error_widget.dart';
import 'package:getout/screens/movies/widgets/movies_liked/movies_liked.dart';
import 'package:getout/screens/movies/bloc/movies_liked/movies_liked_bloc.dart';

class MoviesLikedWidget extends StatelessWidget {
  const MoviesLikedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesLikedBloc, MoviesLikedState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return MoviesLikedSuccessWidget(movies: state.moviesLiked);
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
