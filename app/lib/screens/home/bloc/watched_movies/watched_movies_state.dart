/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'watched_movies_bloc.dart';

enum MoviesWatchedStatus { initial, success, error, loading, selected }

extension MoviesWatchedStatusX on MoviesWatchedStatus {
  bool get isInitial => this == MoviesWatchedStatus.initial;
  bool get isSuccess => this == MoviesWatchedStatus.success;
  bool get isError => this == MoviesWatchedStatus.error;
  bool get isLoading => this == MoviesWatchedStatus.loading;
  bool get isSelected => this == MoviesWatchedStatus.selected;
}

class WatchedMoviesState extends Equatable {
  const WatchedMoviesState({
    this.status = Status.initial,
    List<MoviePreview>? watchedMovies,
  }) : watchedMovies = watchedMovies ?? const [];

  final List<MoviePreview> watchedMovies;
  final Status status;

  @override
  List<Object?> get props => [status, watchedMovies];

  WatchedMoviesState copyWith({
    List<MoviePreview>? watchedMovies,
    Status? status,
  }) {
    return WatchedMoviesState(
      watchedMovies: watchedMovies ?? this.watchedMovies,
      status: status ?? this.status,
    );
  }

  factory WatchedMoviesState.fromMap(Map<String, dynamic> map) {
    List<MoviePreview> books = [];

    map['watched_movies']!.forEach((element) => {
      books.add(MoviePreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return WatchedMoviesState(
        watchedMovies: books,
        status: stringToStatus[map['watched_movies_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'watched_movies': watchedMovies
          .map((book) => {
        'id': book.id,
        'title': book.title,
        'posterPath': book.posterPath,
        'overview': book.overview,
      }).toList(),
      'watched_movies_status': statusToString[status],
    };
  }
}
