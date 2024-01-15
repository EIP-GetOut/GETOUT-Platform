/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'recommended_movies_bloc.dart';

class RecommendedMoviesState extends Equatable {
  const RecommendedMoviesState({
    this.status = Status.initial,
    List<MoviePreview>? recommendedMovies,
  }) : recommendedMovies = recommendedMovies ?? const [];

  final List<MoviePreview> recommendedMovies;
  final Status status;

  @override
  List<Object?> get props => [status, recommendedMovies];

  RecommendedMoviesState copyWith({
    List<MoviePreview>? recommendedMovies,
    Status? status,
  }) {
    return RecommendedMoviesState(
      recommendedMovies: recommendedMovies ?? this.recommendedMovies,
      status: status ?? this.status,
    );
  }
}
