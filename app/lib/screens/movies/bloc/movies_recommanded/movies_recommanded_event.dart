/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'movies_recommanded_bloc.dart';

class MoviesRecommandedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateMoviesRecommandedRequest extends MoviesRecommandedEvent {
  GenerateMoviesRecommandedRequest({
    required this.genres,
    this.includeAdult = false,
  });
  final List<int> genres;
  final bool includeAdult;
}

class MovieRecommandedPreview extends MoviesRecommandedEvent {
  MovieRecommandedPreview(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});
  final int id;
  final String title;
  final String? posterPath;
  final String? overview;
}

typedef GenerateMoviesRecommandedResponse = List<MovieRecommandedPreview>;
