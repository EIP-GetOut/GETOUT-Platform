/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_recommended_bloc.dart';

enum MoviesRecommendedStatus { initial, success, error, loading, selected }

extension MoviesRecommandedStatusX on MoviesRecommendedStatus {
  bool get isInitial => this == MoviesRecommendedStatus.initial;
  bool get isSuccess => this == MoviesRecommendedStatus.success;
  bool get isError => this == MoviesRecommendedStatus.error;
  bool get isLoading => this == MoviesRecommendedStatus.loading;
  bool get isSelected => this == MoviesRecommendedStatus.selected;
}

class MoviesRecommendedState extends Equatable {
  const MoviesRecommendedState({
    this.status = MoviesRecommendedStatus.initial,
    List<MovieRecommendedPreview>? moviesRecommended,
  }) : moviesRecommended = moviesRecommended ?? const [];

  final List<MovieRecommendedPreview> moviesRecommended;
  final MoviesRecommendedStatus status;

  @override
  List<Object?> get props => [status, moviesRecommended];

  MoviesRecommendedState copyWith({
    List<MovieRecommendedPreview>? moviesRecommended,
    MoviesRecommendedStatus? status,
  }) {
    return MoviesRecommendedState(
      moviesRecommended: moviesRecommended ?? this.moviesRecommended,
      status: status ?? this.status,
    );
  }
}
