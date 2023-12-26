/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'view_books_bloc.dart';

enum ViewBookStatus { initial, success, error, loading }

extension ViewBookStatusX on ViewBookStatus {
  bool get isInitial => this == ViewBookStatus.initial;
  bool get isSuccess => this == ViewBookStatus.success;
  bool get isError => this == ViewBookStatus.error;
  bool get isLoading => this == ViewBookStatus.loading;
}

class ViewBooksState extends Equatable {
  const ViewBooksState({
    this.status = ViewBookStatus.initial,
    List<ViewBookPreview>? books,
  }) : books = books ?? const [];

  final List<ViewBookPreview> books;
  final ViewBookStatus status;

  @override
  List<Object?> get props => [status, books];

  ViewBooksState copyWith({List<ViewBookPreview>? books, ViewBookStatus? status}) {
    return ViewBooksState(
      books: books ?? this.books,
      status: status ?? this.status,
    );
  }
}
