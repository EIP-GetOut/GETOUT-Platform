/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'saved_books_bloc.dart';

class SavedBooksState extends Equatable {
  const SavedBooksState({
    this.status = Status.initial,
    List<BookPreview>? savedBooks,
  }) : savedBooks = savedBooks ?? const [];

  final List<BookPreview> savedBooks;
  final Status status;

  @override
  List<Object?> get props => [status, savedBooks];

  SavedBooksState copyWith({
    List<BookPreview>? savedBooks,
    Status? status,
  }) {
    return SavedBooksState(
      savedBooks: savedBooks ?? this.savedBooks,
      status: status ?? this.status,
    );
  }

  factory SavedBooksState.fromMap(Map<String, dynamic> map) {
    if (kDebugMode) {
      print('saved_books.fromMap:${map['saved_books_status']}');
    }
    List<BookPreview> books = [];

    map['saved_books']!.forEach((element) => {
      books.add(BookPreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return SavedBooksState(
        savedBooks: books,
        status: stringToStatus[map['saved_books_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    if (kDebugMode) {
      print('saved_books.toMap:${statusToString[status]}');
    }
    return {
      'saved_books': savedBooks
          .map((book) => {
        'id': book.id,
        'title': book.title,
        'posterPath': book.posterPath,
        'overview': book.overview,
      }).toList(),
      'saved_books_status': statusToString[status],
    };
  }
}
