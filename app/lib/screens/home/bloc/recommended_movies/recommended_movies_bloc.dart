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

part 'recommended_movies_state.dart';

class RecommendedMoviesBloc extends Bloc<MoviesEvent, RecommendedMoviesState> {
  final HomeRepository homeRepository;

  RecommendedMoviesBloc({
    required this.homeRepository,
  }) : super(const RecommendedMoviesState()) {
    on<GenerateMoviesRequest>(_onGenerateMoviesRequestEvent);
  }

  void _onGenerateMoviesRequestEvent(
      GenerateMoviesRequest event, Emitter<RecommendedMoviesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final recommendedMovies = await homeRepository.getRecommendedMovies(event);
      emit(
        state.copyWith(
          status: Status.success,
          recommendedMovies: recommendedMovies,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
