/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'recommended_books_bloc.dart';

class RecommendedBooksState extends Equatable {
  const RecommendedBooksState({
    this.status = Status.initial,
    List<BookPreview>? recommendedBooks,
  }) : recommendedBooks = recommendedBooks ?? const [];

  final List<BookPreview> recommendedBooks;
  final Status status;

  @override
  List<Object?> get props => [status, recommendedBooks];

  RecommendedBooksState copyWith({
    List<BookPreview>? recommendedBooks,
    Status? status,
  }) {
    return RecommendedBooksState(
      recommendedBooks: recommendedBooks,
      status: status ?? this.status,
    );
  }
}
