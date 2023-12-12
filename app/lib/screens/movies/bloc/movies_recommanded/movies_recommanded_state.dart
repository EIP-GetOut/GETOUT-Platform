/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_recommanded_bloc.dart';

enum MoviesRecommandedStatus { initial, success, error, loading, selected }

extension MoviesRecommandedStatusX on MoviesRecommandedStatus {
  bool get isInitial => this == MoviesRecommandedStatus.initial;
  bool get isSuccess => this == MoviesRecommandedStatus.success;
  bool get isError => this == MoviesRecommandedStatus.error;
  bool get isLoading => this == MoviesRecommandedStatus.loading;
  bool get isSelected => this == MoviesRecommandedStatus.selected;
}

class MoviesRecommandedState extends Equatable {
  const MoviesRecommandedState({
    this.status = MoviesRecommandedStatus.initial,
    List<MovieRecommandedPreview>? moviesRecommanded,
  }) : moviesRecommanded = moviesRecommanded ?? const [];

  final List<MovieRecommandedPreview> moviesRecommanded;
  final MoviesRecommandedStatus status;

  @override
  List<Object?> get props => [status, moviesRecommanded];

  MoviesRecommandedState copyWith({
    List<MovieRecommandedPreview>? moviesRecommanded,
    MoviesRecommandedStatus? status,
  }) {
    return MoviesRecommandedState(
      moviesRecommanded: moviesRecommanded ?? this.moviesRecommanded,
      status: status ?? this.status,
    );
  }
}
