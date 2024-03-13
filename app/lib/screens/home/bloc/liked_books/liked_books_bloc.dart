/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';
import 'package:getout/tools/status.dart';

part 'liked_books_state.dart';

class LikedBooksHydratedBloc extends HydratedBloc<BooksEvent, LikedBooksState> {
  final HomeRepository homeRepository;

  LikedBooksHydratedBloc({
    required this.homeRepository,
  }) : super(const LikedBooksState()) {
    on<GenerateBooksRequest>(_onLikedBooksRequest);
  }

  void _onLikedBooksRequest(
      GenerateBooksRequest event, Emitter<LikedBooksState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final likedBooks = await homeRepository.getLikedBooks(event);
      emit(
        state.copyWith(
          status: Status.success,
          likedBooks: likedBooks,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  LikedBooksState? fromJson(Map<String, dynamic> json) {
    return LikedBooksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LikedBooksState state) {
    return state.toMap();
  }

}
