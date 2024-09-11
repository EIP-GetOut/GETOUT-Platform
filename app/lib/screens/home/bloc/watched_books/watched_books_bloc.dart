/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:getout/screens/home/services/service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';

part 'watched_books_state.dart';

class WatchedBooksHydratedBloc extends HydratedBloc<BooksEvent, WatchedBooksState> {
  final HomeService homeService;

  WatchedBooksHydratedBloc({
    required this.homeService,
  }) : super(const WatchedBooksState()) {
    on<GenerateBooksRequest>(_onWatchedBooksRequest);
  }

  void _onWatchedBooksRequest(
      GenerateBooksRequest event, Emitter<WatchedBooksState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final watchedBooks = await homeService.getWatchedBooks(event);
      emit(
        state.copyWith(
          status: Status.success,
          watchedBooks: watchedBooks,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  WatchedBooksState? fromJson(Map<String, dynamic> json) {
    return WatchedBooksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(WatchedBooksState state) {
    return state.toMap();
  }
}
