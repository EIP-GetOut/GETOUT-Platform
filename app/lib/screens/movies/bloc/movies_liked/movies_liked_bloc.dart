/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/movies/bloc/movies/movies_repository.dart';

part 'movies_liked_event.dart';
part 'movies_liked_state.dart';

class MoviesLikedBloc extends Bloc<MoviesLikedEvent, MoviesLikedState> {
  MoviesLikedBloc({
    required this.moviesRepository,
  }) : super(const MoviesLikedState()) {
    on<GenerateMoviesLikedRequest>(_mapGetMoviesLikedEventToState);
  }

  final MoviesRepository moviesRepository;

  void _mapGetMoviesLikedEventToState(
      GenerateMoviesLikedRequest event, Emitter<MoviesLikedState> emit) async {
    emit(state.copyWith(status: MoviesLikedStatus.loading));
    try {
      final moviesLiked = await moviesRepository.getMoviesLiked(event);
      emit(
        state.copyWith(
          status: MoviesLikedStatus.success,
          moviesLiked: moviesLiked,
        ),
      );
    } catch (error) {
      // print(stacktrace);
      emit(state.copyWith(status: MoviesLikedStatus.error));
    }
  }
}
