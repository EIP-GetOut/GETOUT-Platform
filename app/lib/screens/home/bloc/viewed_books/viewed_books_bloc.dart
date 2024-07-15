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

part 'viewed_books_state.dart';

class ViewedBooksHydratedBloc extends HydratedBloc<BooksEvent, ViewedBooksState> {
  final HomeService homeService;

  ViewedBooksHydratedBloc({
    required this.homeService,
  }) : super(const ViewedBooksState()) {
    on<GenerateBooksRequest>(_onViewedBooksRequest);
  }

  void _onViewedBooksRequest(
      GenerateBooksRequest event, Emitter<ViewedBooksState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final viewedBooks = await homeService.getViewedBooks(event);
      emit(
        state.copyWith(
          status: Status.success,
          viewedBooks: viewedBooks,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  ViewedBooksState? fromJson(Map<String, dynamic> json) {
    return ViewedBooksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ViewedBooksState state) {
    return state.toMap();
  }
}
