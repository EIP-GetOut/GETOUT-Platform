/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/home/bloc/home_repository.dart';

part 'view_books_event.dart';
part 'view_books_state.dart';

class ViewBooksBloc extends Bloc<ViewBooksEvent, ViewBooksState> {

  ViewBooksBloc({
    required this.homeRepository,
  }) : super(const ViewBooksState()) {
    on<GetViewBooksRequest>(_mapGetViewBooksEventToState);
  }

  final HomeRepository homeRepository;

  void _mapGetViewBooksEventToState(
      GetViewBooksRequest event, Emitter<ViewBooksState> emit) async {
    emit(state.copyWith(status: ViewBookStatus.loading));
    try {
      final books = await homeRepository.getViewBooks(event);
      emit(
        state.copyWith(
          status: ViewBookStatus.success,
          books: books,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ViewBookStatus.error));
    }
  }
}
