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
}
