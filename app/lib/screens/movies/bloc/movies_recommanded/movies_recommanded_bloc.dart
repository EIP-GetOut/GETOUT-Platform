/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/movies/bloc/movies/movies_repository.dart';

part 'movies_recommanded_event.dart';
part 'movies_recommanded_state.dart';

class MoviesRecommandedBloc extends Bloc<MoviesRecommandedEvent, MoviesRecommandedState> {
  MoviesRecommandedBloc({
    required this.moviesRepository,
  }) : super(const MoviesRecommandedState()) {
    on<GenerateMoviesRecommandedRequest>(_mapGetMoviesRecommandedEventToState);
  }

  final MoviesRepository moviesRepository;

  void _mapGetMoviesRecommandedEventToState(
      GenerateMoviesRecommandedRequest event, Emitter<MoviesRecommandedState> emit) async {
    emit(state.copyWith(status: MoviesRecommandedStatus.loading));
    try {
      final moviesRecommanded = await moviesRepository.getMoviesRecommanded(event);
      emit(
        state.copyWith(
          status: MoviesRecommandedStatus.success,
          moviesRecommanded: moviesRecommanded,
        ),
      );
    } catch (error) {
      // print(stacktrace);
      emit(state.copyWith(status: MoviesRecommandedStatus.error));
    }
  }
}
