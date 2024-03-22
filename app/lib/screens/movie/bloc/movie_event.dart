/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movie_bloc.dart';

// Equatable check if two objects are equals
class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class CreateInfoMovieRequest extends MovieEvent {
  final int id;

  const CreateInfoMovieRequest({required this.id});
}

class InfoMovieResponse extends MovieEvent {
  final List<Map<String, String?>>? cast;
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

  const InfoMovieResponse(
      {this.title,
      this.overview,
      this.posterPath,
      this.backdropPath,
      this.releaseDate,
      this.voteAverage,
      this.duration,
      this.cast,
      this.liked,
      this.disliked,
      this.wishlisted,
      this.seen,
      this.id,
      required this.statusCode});
}

class AddMovieRequest extends MovieEvent {
  final int id;

  const AddMovieRequest (
    {required this.id}
  );
}

class AddMovieResponse extends MovieEvent {
  final int statusCode;

  const AddMovieResponse (
    {required this.statusCode}
  );


}

