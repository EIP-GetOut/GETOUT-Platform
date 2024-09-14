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

    map['recommended_movies']!.forEach((element) => {
          movies.add(MoviePreview(
              id: element['id'],
              title: element['title'],
              posterPath: element['posterPath'],
              overview: element['synopsis'],
              releaseDate: element['releaseDate'],
              averageRating: element['averageRating'],
              genres: element['genres']
          ))
        });
    return RecommendedMoviesState(
        recommendedMovies: movies,
        status: stringToStatus[map['recommended_movies_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'recommended_movies': recommendedMovies
          .map((movie) => {
                'id': movie.id,
                'title': movie.title,
                'posterPath': movie.posterPath,
                'overview': movie.overview,
                'releaseDate': movie.releaseDate,
                'averageRating': movie.averageRating,
                'genres': movie.genres
              })
          .toList(),
      'recommended_movies_status': statusToString[status],
    };
  }
}
