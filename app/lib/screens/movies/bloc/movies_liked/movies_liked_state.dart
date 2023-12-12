/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_liked_bloc.dart';

enum MoviesLikedStatus { initial, success, error, loading, selected }

extension MoviesLikedStatusX on MoviesLikedStatus {
  bool get isInitial => this == MoviesLikedStatus.initial;
  bool get isSuccess => this == MoviesLikedStatus.success;
  bool get isError => this == MoviesLikedStatus.error;
  bool get isLoading => this == MoviesLikedStatus.loading;
  bool get isSelected => this == MoviesLikedStatus.selected;
}

class MoviesLikedState extends Equatable {
  const MoviesLikedState({
    this.status = MoviesLikedStatus.initial,
    List<MovieLikedPreview>? moviesLiked,
  }) : moviesLiked = moviesLiked ?? const [];

  final List<MovieLikedPreview> moviesLiked;
  final MoviesLikedStatus status;

  @override
  List<Object?> get props => [status, moviesLiked];

  MoviesLikedState copyWith({
    List<MovieLikedPreview>? moviesLiked,
    MoviesLikedStatus? status,
  }) {
    return MoviesLikedState(
      moviesLiked: moviesLiked ?? this.moviesLiked,
      status: status ?? this.status,
    );
  }
}
