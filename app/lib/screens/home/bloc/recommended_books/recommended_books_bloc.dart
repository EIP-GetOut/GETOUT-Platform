/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/home_repository.dart';

part 'recommended_books_state.dart';

class RecommendedBooksBloc extends Bloc<BooksEvent, RecommendedBooksState> {
  final HomeRepository homeRepository;

  RecommendedBooksBloc({
    required this.homeRepository,
  }) : super(const RecommendedBooksState()) {
    on<GenerateBooksRequest>(_onRecommendedBooksRequest);
  }

  void _onRecommendedBooksRequest(
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
      // print(stacktrace);
      emit(state.copyWith(status: Status.error));
    }
  }
}
