/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/movies/bloc/movies/movies_repository.dart';

part 'movies_recommended_event.dart';
part 'movies_recommended_state.dart';

class MoviesRecommendedBloc extends Bloc<MoviesRecommendedEvent, MoviesRecommendedState> {
  MoviesRecommendedBloc({
    required this.moviesRepository,
  }) : super(const MoviesRecommendedState()) {
    on<GenerateMoviesRecommendedRequest>(_mapGetMoviesRecommendedEventToState);
  }

  final MoviesRepository moviesRepository;

  void _mapGetMoviesRecommendedEventToState(
      GenerateMoviesRecommendedRequest event, Emitter<MoviesRecommendedState> emit) async {
    emit(state.copyWith(status: MoviesRecommendedStatus.loading));
    try {
      final moviesRecommended = await moviesRepository.getMoviesRecommended(event);
      emit(
        state.copyWith(
          status: MoviesRecommendedStatus.success,
          moviesRecommended: moviesRecommended,
        ),
      );
    } catch (error) {
      // print(stacktrace);
      emit(state.copyWith(status: MoviesRecommendedStatus.error));
    }
  }
}
