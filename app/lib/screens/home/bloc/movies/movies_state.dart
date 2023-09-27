/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_bloc.dart';

enum MovieStatus { initial, success, error, loading, selected }

extension MovieStatusX on MovieStatus {
  bool get isInitial => this == MovieStatus.initial;
  bool get isSuccess => this == MovieStatus.success;
  bool get isError => this == MovieStatus.error;
  bool get isLoading => this == MovieStatus.loading;
  bool get isSelected => this == MovieStatus.selected;
}

class MoviesState extends Equatable {
  const MoviesState({
    this.status = MovieStatus.initial,
    List<MoviePreview>? movies,
  }) : movies = movies ?? const [];

  final List<MoviePreview> movies;
  final MovieStatus status;

  @override
  List<Object?> get props => [status, movies];

  MoviesState copyWith({
    List<MoviePreview>? movies,
    MovieStatus? status,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
    );
  }
}
