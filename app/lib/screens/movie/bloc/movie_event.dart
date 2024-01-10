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
      required this.statusCode});

  static const int success = HttpStatus.OK;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  final String? duration;
  final int statusCode;
}
