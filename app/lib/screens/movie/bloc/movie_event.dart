/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movie_bloc.dart';

// Equatable check if two objects are equals
class MovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const MovieEvent();
}

class CreateInfoMovieRequest extends MovieEvent {
  const CreateInfoMovieRequest({required this.id});

  final int id;
}

class InfoMovieResponse extends MovieEvent {
  const InfoMovieResponse(
      {this.title,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.releaseDate,
      this.voteAverage,
      this.duration,
      this.cast,
      this.director,
      this.liked,
      this.disliked,
      this.wishlisted,
      this.seen,
      this.id,
      required this.statusCode});

  final List<Map<String, String?>>? cast;
  final List<Map<String, String?>>? director;
  static const int success = HttpStatus.OK;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final int? duration;
  final bool? liked;
  final bool? disliked;
  final bool? wishlisted;
  final bool? seen;
  final int statusCode;
  final int? id;
}

class AddMovieRequest extends MovieEvent {
  const AddMovieRequest (
    {required this.id}
  );

  final int id;
}

class AddMovieResponse extends MovieEvent {
  const AddMovieResponse (
    {required this.statusCode}
  );

  final int statusCode;

  static const int success = HttpStatus.OK;
}

