/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/movies/bloc/movies/movies_repository.dart';

part 'movies_saved_event.dart';
part 'movies_saved_state.dart';

class MoviesSavedBloc extends Bloc<MoviesSavedEvent, MoviesSavedState> {
  MoviesSavedBloc({
    required this.moviesRepository,
  }) : super(const MoviesSavedState()) {
    on<GenerateMoviesSavedRequest>(_mapGetMoviesSavedEventToState);
  }

  final MoviesRepository moviesRepository;

  void _mapGetMoviesSavedEventToState(
      GenerateMoviesSavedRequest event, Emitter<MoviesSavedState> emit) async {
    emit(state.copyWith(status: MoviesSavedStatus.loading));
    try {
      final moviesSaved = await moviesRepository.getMoviesSaved(event);
      emit(
        state.copyWith(
          status: MoviesSavedStatus.success,
          moviesSaved: moviesSaved,
        ),
      );
    } catch (error) {
      // print(stacktrace);
      emit(state.copyWith(status: MoviesSavedStatus.error));
    }
  }
}
