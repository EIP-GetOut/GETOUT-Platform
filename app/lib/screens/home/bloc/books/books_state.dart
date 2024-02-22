/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';

//todo make every books bloc use this state.
class ListBooksState extends Equatable {
  const ListBooksState({
    this.status = Status.initial,
    List<BookPreview>? listBooks,
  }) : listBooks = listBooks ?? const [];

  final List<BookPreview> listBooks;
  final Status status;

  @override
  List<Object?> get props => [status, listBooks];

  ListBooksState copyWith({
    List<BookPreview>? listBooks,
    Status? status,
  }) {
    return ListBooksState(
      listBooks: listBooks,
      status: status ?? this.status,
    );
  }

  factory ListBooksState.fromMap(Map<String, dynamic> map) {
    List<BookPreview> books = [];

    map['recommended']!.forEach((element) => {
          books.add(BookPreview(
              id: element['id'],
              title: element['title'],
              posterPath: element['posterPath'],
              overview: element['overview']))
        });
    return ListBooksState(
        listBooks: books,
        status: stringToStatus[map['status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'recommended': listBooks
          .map((book) => {
                'id': book.id,
                'title': book.title,
                'posterPath': book.posterPath,
                'overview': book.overview,
              })
          .toList(),
      'status': statusToString[status],
    };
  }
}
