/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:getout/screens/home/bloc/dashboard/dashboard_repository.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({
    required this.dashboardRepository,
  }) : super(const MoviesState()) {
    on<GenerateMoviesRequest>(_mapGetMoviesEventToState);
    on<SelectMovie>(_mapSelectMoviesEventToState);
  }

  final DashboardRepository dashboardRepository;

  void _mapGetMoviesEventToState(
      GenerateMoviesRequest event, Emitter<MoviesState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    try {
      final movies = await dashboardRepository.getMovies(event);
      emit(
        state.copyWith(
          status: MovieStatus.success,
          movies: movies,
        ),
      );
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: MovieStatus.error));
    }
  }

//TODO: on garde le selectmovie ??
  void _mapSelectMoviesEventToState(
      SelectMovie event, Emitter<MoviesState> emit) async {
    emit(
      state.copyWith(
        status: MovieStatus.selected,
        idSelected: event.idSelected,
      ),
    );
  }
}
