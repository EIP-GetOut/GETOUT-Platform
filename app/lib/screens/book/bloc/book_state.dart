/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'book_bloc.dart';

enum BookStatus { initial, success, error, loading }

extension BookStatusX on BookStatus {
  bool get isInitial => this == BookStatus.initial;
  bool get isSuccess => this == BookStatus.success;
  bool get isError => this == BookStatus.error;
  bool get isLoading => this == BookStatus.loading;
}

class BookState extends Equatable {
  BookState({
    this.status = BookStatus.initial,
    InfoBookResponse? book,
  }) : book = book ?? InfoBookResponse(statusCode: 200);

  final InfoBookResponse book;
  final BookStatus status;

  @override
  List<Object?> get props => [status, book];

  BookState copyWith({
    InfoBookResponse? book,
    BookStatus? status,
  }) {
    return BookState(
      book: book ?? this.book,
      status: status ?? this.status,
    );
  }
}
