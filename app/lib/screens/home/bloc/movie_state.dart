/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movie_bloc.dart';

enum MovieStatus { initial, success, error, loading, selected }

extension MovieStatusX on MovieStatus {
  bool get isInitial => this == MovieStatus.initial;
  bool get isSuccess => this == MovieStatus.success;
  bool get isError => this == MovieStatus.error;
  bool get isLoading => this == MovieStatus.loading;
  // bool get isSelected => this == MovieStatus.selected;
}

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    List<MoviePreview>? movies,
    // int idSelected = 0,
  }) : movies = movies ?? const [];
  // idSelected = idSelected;

  final List<MoviePreview> movies;
  final MovieStatus status;
  // final int idSelected;

  @override
  List<Object?> get props => [status, movies];
  // , idSelected

  MovieState copyWith({
    List<MoviePreview>? movies,
    MovieStatus? status,
    int? idSelected,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      // idSelected: idSelected ?? this.idSelected,
    );
  }
}
