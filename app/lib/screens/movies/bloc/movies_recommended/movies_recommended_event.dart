/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_recommended_bloc.dart';

class MoviesRecommendedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateMoviesRecommendedRequest extends MoviesRecommendedEvent {
  GenerateMoviesRecommendedRequest({
    required this.genres,
    this.includeAdult = false,
  });
  final List<int> genres;
  final bool includeAdult;
}

class MovieRecommendedPreview extends MoviesRecommendedEvent {
  MovieRecommendedPreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
}

typedef GenerateMoviesRecommendedResponse = List<MovieRecommendedPreview>;
