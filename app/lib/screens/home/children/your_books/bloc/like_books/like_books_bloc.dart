/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';

part 'like_books_event.dart';
part 'like_books_state.dart';

class LikeBooksBloc extends Bloc<LikeBooksEvent, LikeBooksState> {

  LikeBooksBloc({
    required this.homeRepository,
  }) : super(const LikeBooksState ()) {
    on<GetLikeBooksRequest>(_mapGetLikeBooksEventToState);
  }

  final HomeRepository homeRepository;

  void _mapGetLikeBooksEventToState(
      GetLikeBooksRequest event, Emitter<LikeBooksState> emit) async {
    emit(state.copyWith(status: LikeBookStatus.loading));
    try {
      final books = await homeRepository.getLikeBooks(event);
      emit(
        state.copyWith(
          status: LikeBookStatus.success,
          books: books,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: LikeBookStatus.error));
    }
  }
}