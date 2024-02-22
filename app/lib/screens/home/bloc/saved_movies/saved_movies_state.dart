/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'saved_movies_bloc.dart';

enum MoviesSavedStatus { initial, success, error, loading, selected }

extension MoviesSavedStatusX on MoviesSavedStatus {
  bool get isInitial => this == MoviesSavedStatus.initial;
  bool get isSuccess => this == MoviesSavedStatus.success;
  bool get isError => this == MoviesSavedStatus.error;
  bool get isLoading => this == MoviesSavedStatus.loading;
  bool get isSelected => this == MoviesSavedStatus.selected;
}

class SavedMoviesState extends Equatable {
  const SavedMoviesState({
    this.status = Status.initial,
    List<MoviePreview>? savedMovies,
  }) : savedMovies = savedMovies ?? const [];

  final List<MoviePreview> savedMovies;
  final Status status;

  @override
  List<Object?> get props => [status, savedMovies];

  SavedMoviesState copyWith({
    List<MoviePreview>? savedMovies,
    Status? status,
  }) {
    return SavedMoviesState(
      savedMovies: savedMovies ?? this.savedMovies,
      status: status ?? this.status,
    );
  }

  factory SavedMoviesState.fromMap(Map<String, dynamic> map) {
    if (kDebugMode) {
      print('saved_movies.fromMap:${map['saved_movies_status']}');
    }
    List<MoviePreview> books = [];

    map['saved_movies']!.forEach((element) => {
      books.add(MoviePreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return SavedMoviesState(
        savedMovies: books,
        status: stringToStatus[map['saved_movies_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    if (kDebugMode) {
      print('saved_movies.toMap:${statusToString[status]}');
    }
    return {
      'saved_movies': savedMovies
          .map((book) => {
        'id': book.id,
        'title': book.title,
        'posterPath': book.posterPath,
        'overview': book.overview,
      }).toList(),
      'saved_movies_status': statusToString[status],
    };
  }
}
