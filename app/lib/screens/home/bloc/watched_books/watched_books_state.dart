/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'watched_books_bloc.dart';

class WatchedBooksState extends Equatable {
  const WatchedBooksState({
    this.status = Status.initial,
    List<BookPreview>? watchedBooks,
  }) : watchedBooks = watchedBooks ?? const [];

  final List<BookPreview> watchedBooks;
  final Status status;

  @override
  List<Object?> get props => [status, watchedBooks];

  WatchedBooksState copyWith({
    List<BookPreview>? watchedBooks,
    Status? status,
  }) {
    return WatchedBooksState(
      watchedBooks: watchedBooks ?? this.watchedBooks,
      status: status ?? this.status,
    );
  }

  factory WatchedBooksState.fromMap(Map<String, dynamic> map) {
    List<BookPreview> books = [];

    map['watched_books']!.forEach((element) => {
      books.add(BookPreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return WatchedBooksState(
        watchedBooks: books,
        status: stringToStatus[map['watched_books_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'watched_books': watchedBooks
          .map((book) => {
        'id': book.id,
        'title': book.title,
        'posterPath': book.posterPath,
        'overview': book.overview,
      }).toList(),
      'watched_books_status': statusToString[status],
    };
  }
}
