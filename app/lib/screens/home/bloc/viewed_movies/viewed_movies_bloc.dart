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

part 'viewed_movies_state.dart';

class ViewedMoviesHydratedBloc extends HydratedBloc<MoviesEvent, ViewedMoviesState> {
  final HomeService homeService;

  ViewedMoviesHydratedBloc({
    required this.homeService,
  }) : super(const ViewedMoviesState()) {
    on<GenerateMoviesRequest>(_onViewedMoviesRequest);
  }

  void _onViewedMoviesRequest(
      GenerateMoviesRequest event, Emitter<ViewedMoviesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final moviesSaved = await homeService.getSavedMovies(event);
      emit(
        state.copyWith(
          status: Status.success,
          viewedMovies: moviesSaved,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  ViewedMoviesState? fromJson(Map<String, dynamic> json) {
    return ViewedMoviesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ViewedMoviesState state) {
    return state.toMap();
  }

}
