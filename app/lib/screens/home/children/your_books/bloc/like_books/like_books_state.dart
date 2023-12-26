/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'like_books_bloc.dart';

enum LikeBookStatus { initial, success, error, loading }

extension LikeBookStatusX on LikeBookStatus {
  bool get isInitial => this == LikeBookStatus.initial;
  bool get isSuccess => this == LikeBookStatus.success;
  bool get isError => this == LikeBookStatus.error;
  bool get isLoading => this == LikeBookStatus.loading;
}

class LikeBooksState extends Equatable {
  const LikeBooksState({
    this.status = LikeBookStatus.initial,
    List<LikeBookPreview>? books,
  }) : books = books ?? const [];

  final List<LikeBookPreview> books;
  final LikeBookStatus status;

  @override
  List<Object?> get props => [status, books];

  LikeBooksState copyWith({List<LikeBookPreview>? books, LikeBookStatus? status}) {
    return LikeBooksState(
      books: books ?? this.books,
      status: status ?? this.status,
    );
  }
}
