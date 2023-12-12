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
}

class GenerateMoviesLikedRequest extends MoviesLikedEvent {
  GenerateMoviesLikedRequest({
    required this.genres,
    this.includeAdult = false,
  });
  final List<int> genres;
  final bool includeAdult;
}

class MovieLikedPreview extends MoviesLikedEvent {
  MovieLikedPreview(
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
