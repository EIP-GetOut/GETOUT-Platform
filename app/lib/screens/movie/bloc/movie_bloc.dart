/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/movie/bloc/movie_service.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieService movieService;

  MovieBloc({
    required this.movieService,
  }) : super(const MovieState()) {
    on<CreateInfoMovieRequest>(_mapGetMovieEventToState);
  }


  void _mapGetMovieEventToState(
      CreateInfoMovieRequest event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final InfoMovieResponse movie = await movieService.getInfoMovie(event);
      emit(
        state.copyWith(
          status: MovieStatus.success,
          movie: movie,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MovieStatus.error));
    }
  }
}
