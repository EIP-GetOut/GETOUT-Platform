/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/
part of 'movie_bloc.dart';

enum MovieStatus { initial, success, error, loading }

extension MovieStatusX on MovieStatus {
  bool get isInitial => this == MovieStatus.initial;
  bool get isSuccess => this == MovieStatus.success;
  bool get isError => this == MovieStatus.error;
  bool get isLoading => this == MovieStatus.loading;
}

class MovieState extends Equatable {
  const MovieState({
    this.status = MovieStatus.initial,
    InfoMovieResponse? movie,
  }) : movie = movie ?? const InfoMovieResponse(statusCode: 200);

  final InfoMovieResponse movie;
  final MovieStatus status;

  @override
  List<Object?> get props => [status, movie];

  MovieState copyWith({
    InfoMovieResponse? movie,
    MovieStatus? status,
  }) {
    return MovieState(
      movie: movie ?? this.movie,
      status: status ?? this.status,
    );
  }
}
