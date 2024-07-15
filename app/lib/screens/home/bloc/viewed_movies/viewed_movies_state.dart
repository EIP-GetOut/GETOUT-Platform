/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'viewed_movies_bloc.dart';

class ViewedMoviesState extends Equatable {
  const ViewedMoviesState({
    this.status = Status.initial,
    List<MoviePreview>? viewedMovies,
  }) : viewedMovies = viewedMovies ?? const [];

  final List<MoviePreview> viewedMovies;
  final Status status;

  @override
  List<Object?> get props => [status, viewedMovies];

  ViewedMoviesState copyWith({
    List<MoviePreview>? viewedMovies,
    Status? status,
  }) {
    return ViewedMoviesState(
      viewedMovies: viewedMovies ?? this.viewedMovies,
      status: status ?? this.status,
    );
  }

  factory ViewedMoviesState.fromMap(Map<String, dynamic> map) {
    List<MoviePreview> books = [];

    map['viewed_movies']!.forEach((element) => {
      books.add(MoviePreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return ViewedMoviesState(
        viewedMovies: books,
        status: stringToStatus[map['viewed_movies_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'viewed_movies': viewedMovies
          .map((book) => {
        'id': book.id,
        'title': book.title,
        'posterPath': book.posterPath,
        'overview': book.overview,
      }).toList(),
      'viewed_movies_status': statusToString[status],
    };
  }
}
