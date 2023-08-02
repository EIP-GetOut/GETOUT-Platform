/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:getout/screens/home/bloc/dashboard_bloc.dart';

import 'package:getout/screens/home/bloc/dashboard_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MoviesBloc extends Bloc<MovieEvent, MovieState> {
  MoviesBloc({
    required this.dashboardRepository,
  }) : super(const MovieState()) {
    on<GenerateMoviesRequest>(_mapGetMoviesEventToState);
    on<SelectMovie>(_mapSelectMovieEventToState);
  }

  final DashboardRepository dashboardRepository;

  void _mapGetMoviesEventToState(
      GenerateMoviesRequest event, Emitter<MovieState> emit) async {
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

  void _mapSelectMovieEventToState(
      SelectMovie event, Emitter<MovieState> emit) async {
    emit(
      state.copyWith(
        status: MovieStatus.selected,
        idSelected: event.idSelected,
      ),
    );
  }
}
