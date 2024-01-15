/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';

part 'saved_movies_state.dart';

class SavedMoviesBloc extends Bloc<MoviesEvent, SavedMoviesState> {
  final HomeRepository homeRepository;

  SavedMoviesBloc({
    required this.homeRepository,
  }) : super(const SavedMoviesState()) {
    on<GenerateMoviesRequest>(_mapGetMoviesSavedEventToState);
  }


  void _mapGetMoviesSavedEventToState(
      GenerateMoviesRequest event, Emitter<SavedMoviesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final moviesSaved = await homeRepository.getSavedMovies(event);
      emit(
        state.copyWith(
          status: Status.success,
          savedMovies: moviesSaved,
        ),
      );
    } catch (error) {
      // print(stacktrace);
      emit(state.copyWith(status: Status.error));
    }
  }
}
