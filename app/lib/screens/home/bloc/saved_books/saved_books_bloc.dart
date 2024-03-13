/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';

part 'saved_books_state.dart';

class SavedBooksHydratedBloc extends HydratedBloc<BooksEvent, SavedBooksState> {
  final HomeRepository homeRepository;

  SavedBooksHydratedBloc({
    required this.homeRepository,
  }) : super(const SavedBooksState()) {
    on<GenerateBooksRequest>(_onSavedBooksRequest);
  }

  void _onSavedBooksRequest(
      GenerateBooksRequest event, Emitter<SavedBooksState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final savedBooks = await homeRepository.getSavedBooks(event);
      emit(
        state.copyWith(
          status: Status.success,
          savedBooks: savedBooks,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  SavedBooksState? fromJson(Map<String, dynamic> json) {
    return SavedBooksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SavedBooksState state) {
    return state.toMap();
  }
}
