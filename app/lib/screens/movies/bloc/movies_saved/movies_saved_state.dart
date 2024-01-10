/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_saved_bloc.dart';

enum MoviesSavedStatus { initial, success, error, loading, selected }

extension MoviesSavedStatusX on MoviesSavedStatus {
  bool get isInitial => this == MoviesSavedStatus.initial;
  bool get isSuccess => this == MoviesSavedStatus.success;
  bool get isError => this == MoviesSavedStatus.error;
  bool get isLoading => this == MoviesSavedStatus.loading;
  bool get isSelected => this == MoviesSavedStatus.selected;
}

class MoviesSavedState extends Equatable {
  const MoviesSavedState({
    this.status = MoviesSavedStatus.initial,
    List<MovieSavedPreview>? moviesSaved,
  }) : moviesSaved = moviesSaved ?? const [];

  final List<MovieSavedPreview> moviesSaved;
  final MoviesSavedStatus status;

  @override
  List<Object?> get props => [status, moviesSaved];

  MoviesSavedState copyWith({
    List<MovieSavedPreview>? moviesSaved,
    MoviesSavedStatus? status,
  }) {
    return MoviesSavedState(
      moviesSaved: moviesSaved ?? this.moviesSaved,
      status: status ?? this.status,
    );
  }
}
