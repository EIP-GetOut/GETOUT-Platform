/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'history_bloc.dart';

class HistoryState extends Equatable {
  const HistoryState({
    this.status = Status.initial,
    List<BookPreview>? recommendedBooks,
    List<MoviePreview>? recommendedMovies,
  }) : recommendedBooks = recommendedBooks ?? const [],
        recommendedMovies = recommendedMovies ?? const [];

  final List<BookPreview> recommendedBooks;
  final List<MoviePreview> recommendedMovies;
  final Status status;

  @override
  List<Object?> get props => [status, recommendedBooks, recommendedMovies];

  HistoryState copyWith({
    List<BookPreview>? recommendedBooks,
    List<MoviePreview>? recommendedMovies,
    Status? status,
  }) {
    return HistoryState(
      recommendedBooks: recommendedBooks,
      recommendedMovies: recommendedMovies,
      status: status ?? this.status,
    );
  }
}
