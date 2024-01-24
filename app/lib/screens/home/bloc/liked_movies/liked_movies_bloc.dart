/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';

part 'liked_movies_state.dart';

class LikedMoviesBloc extends Bloc<MoviesEvent, LikedMoviesState> {
  final HomeRepository homeRepository;

  LikedMoviesBloc({
    required this.homeRepository,
  }) : super(const LikedMoviesState()) {
    on<GenerateMoviesRequest>(_onLikedMoviesRequest);
  }

  void _onLikedMoviesRequest(
      GenerateMoviesRequest event, Emitter<LikedMoviesState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final likedMovies = await homeRepository.getLikedMovies(event);
      emit(
        state.copyWith(
          status: Status.success,
          likedMovies: likedMovies,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
