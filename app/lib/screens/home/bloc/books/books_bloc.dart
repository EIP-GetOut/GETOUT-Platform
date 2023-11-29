/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/home/bloc/dashboard/dashboard_repository.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {

  BooksBloc({
    required this.dashboardRepository,
  }) : super(const BooksState()) {
    on<GenerateBooksRequest>(_mapGetBooksEventToState);
  }

  final DashboardRepository dashboardRepository;

  void _mapGetBooksEventToState(
      GenerateBooksRequest event, Emitter<BooksState> emit) async {
    emit(state.copyWith(status: BookStatus.loading));
    try {
      final books = await dashboardRepository.getBooks(event);
      emit(
        state.copyWith(
          status: BookStatus.success,
          books: books,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: BookStatus.error));
    }
  }
}
