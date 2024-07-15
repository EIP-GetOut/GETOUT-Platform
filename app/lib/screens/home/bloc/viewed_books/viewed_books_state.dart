/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'viewed_books_bloc.dart';

class ViewedBooksState extends Equatable {
  const ViewedBooksState({
    this.status = Status.initial,
    List<BookPreview>? viewedBooks,
  }) : viewedBooks = viewedBooks ?? const [];

  final List<BookPreview> viewedBooks;
  final Status status;

  @override
  List<Object?> get props => [status, viewedBooks];

  ViewedBooksState copyWith({
    List<BookPreview>? viewedBooks,
    Status? status,
  }) {
    return ViewedBooksState(
      viewedBooks: viewedBooks ?? this.viewedBooks,
      status: status ?? this.status,
    );
  }

  factory ViewedBooksState.fromMap(Map<String, dynamic> map) {
    List<BookPreview> books = [];

    map['viewed_books']!.forEach((element) => {
      books.add(BookPreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return ViewedBooksState(
        viewedBooks: books,
        status: stringToStatus[map['viewed_books_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'viewed_books': viewedBooks
          .map((book) => {
        'id': book.id,
        'title': book.title,
        'posterPath': book.posterPath,
        'overview': book.overview,
      }).toList(),
      'viewed_books_status': statusToString[status],
    };
  }
}
