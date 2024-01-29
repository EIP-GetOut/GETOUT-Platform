/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'liked_books_bloc.dart';

class LikedBooksState extends Equatable {
  const LikedBooksState({
    this.status = Status.initial,
    List<BookPreview>? likedBooks,
  }) : likedBooks = likedBooks ?? const [];

  final List<BookPreview> likedBooks;
  final Status status;

  @override
  List<Object?> get props => [status, likedBooks];

  LikedBooksState copyWith({
    List<BookPreview>? likedBooks,
    Status? status,
  }) {
    return LikedBooksState(
      likedBooks: likedBooks ?? this.likedBooks,
      status: status ?? this.status,
    );
  }
}
