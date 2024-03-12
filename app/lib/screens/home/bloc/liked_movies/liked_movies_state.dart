/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'liked_movies_bloc.dart';

class LikedMoviesState extends Equatable {
  const LikedMoviesState({
    this.status = Status.initial,
    List<MoviePreview>? likedMovies,
  }) : likedMovies = likedMovies ?? const [];

  final List<MoviePreview> likedMovies;
  final Status status;

  @override
  List<Object?> get props => [status, likedMovies];

  LikedMoviesState copyWith({
    List<MoviePreview>? likedMovies,
    Status? status,
  }) {
    return LikedMoviesState(
      likedMovies: likedMovies ?? this.likedMovies,
      status: status ?? this.status,
    );
  }


  factory LikedMoviesState.fromMap(Map<String, dynamic> map) {
    List<MoviePreview> likedMovies = [];

    map['liked_movies']!.forEach((element) => {
      likedMovies.add(MoviePreview(
          id: element['id'],
          title: element['title'],
          posterPath: element['posterPath'],
          overview: element['overview']))
    });
    return LikedMoviesState(
        likedMovies: likedMovies,
        status: stringToStatus[map['liked_movies_status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'liked_movies': likedMovies
          .map((movie) => {
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath,
        'overview': movie.overview,
      }).toList(),
      'liked_movies_status': statusToString[status],
    };
  }
}
