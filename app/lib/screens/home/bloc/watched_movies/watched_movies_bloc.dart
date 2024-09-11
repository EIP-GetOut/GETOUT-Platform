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

part 'watched_movies_state.dart';

class WatchedMoviesHydratedBloc extends HydratedBloc<MoviesEvent, WatchedMoviesState> {
  final HomeService homeService;

  WatchedMoviesHydratedBloc({
    required this.homeService,
  }) : super(const WatchedMoviesState()) {
    on<GenerateMoviesRequest>(_onWatchedMoviesRequest);
  }
  
  void _onWatchedMoviesRequest(
      GenerateMoviesRequest event, Emitter<WatchedMoviesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final moviesWatched = await homeService.getWatchedMovies(event);
      emit(
        state.copyWith(
          status: Status.success,
          watchedMovies: moviesWatched,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  WatchedMoviesState? fromJson(Map<String, dynamic> json) {
    return WatchedMoviesState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(WatchedMoviesState state) {
    return state.toMap();
  }

}
