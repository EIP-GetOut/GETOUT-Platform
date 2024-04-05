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
      likedBooks: likedBooks,
      status: status ?? this.status,
    );
  }

  factory LikedBooksState.fromMap(Map<String, dynamic> map) {
    List<BookPreview> likedBooks = [];
    print('likedFromMap');

    map['liked_books']!.forEach((element) => {
      likedBooks.add(BookPreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return LikedBooksState(
        likedBooks: likedBooks,
        status: stringToStatus[map['liked_books_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    print('likedToMap');
    return {
      'liked_books': likedBooks
          .map((book) => {
        'id': book.id,
        'title': book.title,
        'posterPath': book.posterPath,
        'overview': book.overview,
      })
          .toList(),
      'liked_books_status': statusToString[status],
    };
  }
}
