/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/


import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';

part 'recommended_books_state.dart';

class RecommendedBooksHydratedBloc extends HydratedBloc<BooksEvent, RecommendedBooksState> {
  final HomeRepository homeRepository;

  RecommendedBooksHydratedBloc({
    required this.homeRepository,
  }) : super(const RecommendedBooksState()) {
    on<GenerateBooksRequest>(_onRecmmendedBooksRequest);
  }

  void _onRecmmendedBooksRequest(
      GenerateBooksRequest event, Emitter<RecommendedBooksState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final recommendedBooks = await homeRepository.getRecommendedBooks(event);
      emit(
        state.copyWith(
          status: Status.success,
          recommendedBooks: recommendedBooks,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }

  @override
  RecommendedBooksState? fromJson(Map<String, dynamic> json) {
    return RecommendedBooksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(RecommendedBooksState state) {
    return state.toMap();
  }
}
