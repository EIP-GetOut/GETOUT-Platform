/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';
import 'package:getout/tools/status.dart';

part 'liked_books_state.dart';

class LikedBooksBloc extends Bloc<BooksEvent, LikedBooksState> {
  final HomeRepository homeRepository;

  LikedBooksBloc({
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
}
