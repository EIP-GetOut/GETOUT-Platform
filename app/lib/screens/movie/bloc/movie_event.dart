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
}

class CreateInfoMovieRequest extends MovieEvent {
  CreateInfoMovieRequest({required this.id});

  final int id;
}

//ignore: must_be_immutable
class InfoMovieResponse extends MovieEvent {
  InfoMovieResponse(
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
  String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double? voteAverage;
  String? duration;
  final int statusCode;
}
