/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/


import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/services/service.dart';
import 'package:getout/tools/status.dart';

part 'saved_movies_state.dart';

class SavedMoviesHydratedBloc extends HydratedBloc<MoviesEvent, SavedMoviesState> {
  final HomeService homeService;

  SavedMoviesHydratedBloc({
    required this.homeService,
  }) : super(const SavedMoviesState()) {
    on<GenerateMoviesRequest>(_onSavedMoviesRequest);
  }
  
  void _onSavedMoviesRequest(
      GenerateMoviesRequest event, Emitter<SavedMoviesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final moviesSaved = await homeService.getSavedMovies(event);
      emit(
        state.copyWith(
          status: Status.success,
          savedMovies: moviesSaved,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  SavedMoviesState? fromJson(Map<String, dynamic> json) {
    return SavedMoviesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SavedMoviesState state) {
    return state.toMap();
  }

}
