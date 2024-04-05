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

  factory RecommendedBooksState.fromMap(Map<String, dynamic> map) {
    List<BookPreview> books = [];

    map['recommended_books']!.forEach((element) => {
          books.add(BookPreview(
              id: element['id'],
              title: element['title'],
              posterPath: element['posterPath'],
              overview: element['overview']))
        });
    return RecommendedBooksState(
        recommendedBooks: books,
        status: stringToStatus[map['recommended_books_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'recommended_books': recommendedBooks
          .map((book) => {
                'id': book.id,
                'title': book.title,
                'posterPath': book.posterPath,
                'overview': book.overview,
              })
          .toList(),
      'recommended_books_status': statusToString[status],
    };
  }
}
