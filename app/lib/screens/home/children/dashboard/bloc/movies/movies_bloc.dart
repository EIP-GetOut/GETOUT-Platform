/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Writed by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({
    required this.homeRepository,
  }) : super(const MoviesState()) {
    on<GenerateMoviesRequest>(_mapGetMoviesEventToState);
  }

  final HomeRepository homeRepository;

  void _mapGetMoviesEventToState(
      GenerateMoviesRequest event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final movies = await homeRepository.getMovies(event);
      emit(
        state.copyWith(
          status: MovieStatus.success,
          movies: movies,
        ),
      );
    } catch (error) {
      // print(stacktrace);
      emit(state.copyWith(status: MovieStatus.error));
    }
  }
}
