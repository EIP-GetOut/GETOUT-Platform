/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_liked_bloc.dart';

class MoviesLikedEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const MoviesLikedEvent();
}

class GenerateMoviesLikedRequest extends MoviesLikedEvent {
  const GenerateMoviesLikedRequest({
    required this.genres,
    this.includeAdult = false,
  });
  final List<int> genres;
  final bool includeAdult;
}

class MoviesLikeResponse extends MoviesLikedEvent {
  const MoviesLikeResponse(
      {this.id,
       this.title,
       this.posterPath,
       this.overview,
      required this.statusCode});
  final int? id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int statusCode;
  static const int success = HttpStatus.OK;
}

class MovieLikedPreview extends MoviesLikedEvent {
  const MovieLikedPreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
}

typedef GenerateMoviesLikedResponse = List<MovieLikedPreview>;
