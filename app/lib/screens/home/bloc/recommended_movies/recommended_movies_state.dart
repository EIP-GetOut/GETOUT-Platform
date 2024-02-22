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

  factory RecommendedMoviesState.fromMap(Map<String, dynamic> map) {
    List<MoviePreview> movies = [];

    map['recommended']!.forEach((element) => {
          movies.add(MoviePreview(
              id: element['id'],
              title: element['title'],
              posterPath: element['posterPath'],
              overview: element['overview']))
        });
    return RecommendedMoviesState(
        recommendedMovies: movies,
        status: stringToStatus[map['status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'recommended': recommendedMovies
          .map((book) => {
                'id': book.id,
                'title': book.title,
                'posterPath': book.posterPath,
                'overview': book.overview,
              })
          .toList(),
      'status': statusToString[status],
    };
  }
}
