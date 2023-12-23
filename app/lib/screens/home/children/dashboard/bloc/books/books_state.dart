/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Writed by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'books_bloc.dart';

enum BookStatus { initial, success, error, loading }

extension BookStatusX on BookStatus {
  bool get isInitial => this == BookStatus.initial;
  bool get isSuccess => this == BookStatus.success;
  bool get isError => this == BookStatus.error;
  bool get isLoading => this == BookStatus.loading;
}

class BooksState extends Equatable {
  const BooksState({
    this.status = BookStatus.initial,
    List<BookPreview>? books,
  }) : books = books ?? const [];

  final List<BookPreview> books;
  final BookStatus status;

  @override
  List<Object?> get props => [status, books];

  BooksState copyWith({List<BookPreview>? books, BookStatus? status}) {
    return BooksState(
      books: books ?? this.books,
      status: status ?? this.status,
    );
  }
}
