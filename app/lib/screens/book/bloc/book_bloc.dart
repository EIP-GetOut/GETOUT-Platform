/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/book/bloc/book_service.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookService bookService;

  BookBloc({
    required this.bookService,
  }) : super(const BookState()) {
    on<CreateInfoBookRequest>(_mapGetBookEventToState);
  }

  void _mapGetBookEventToState(
      CreateInfoBookRequest event, Emitter<BookState> emit) async {
    emit(state.copyWith(status: BookStatus.loading));
    try {
      final InfoBookResponse book = await bookService.getInfoBook(event);
      emit(
        state.copyWith(
          status: BookStatus.success,
          book: book,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: BookStatus.error));
    }
  }
}
