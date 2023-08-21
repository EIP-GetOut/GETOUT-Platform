/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:getout/screens/movie/bloc/movie_repository.dart';
import 'package:getout/constants/http_status.dart';

part 'movie_event.dart';
part 'movie_state.dart';

//TODO : supprimer les fichiers useless

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({
    required this.movieRepository,
  }) : super(MovieState()) {
    on<CreateInfoMovieRequest>(_mapGetMovieEventToState);
  }

  final MovieRepository movieRepository;

  void _mapGetMovieEventToState(
      CreateInfoMovieRequest event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final InfoMovieResponse movie = await movieRepository.getInfoMovie(event);
      emit(
        state.copyWith(
          status: MovieStatus.success,
          movie: movie,
        ),
      );
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: MovieStatus.error));
    }
  }
}
