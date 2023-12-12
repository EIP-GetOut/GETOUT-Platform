/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/screens/movies/bloc/movies/movies_service.dart';
import 'package:getout/screens/movies/bloc/movies_liked/movies_liked_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_recommanded/movies_recommanded_bloc.dart';
import 'package:getout/screens/movies/bloc/movies_saved/movies_saved_bloc.dart';

class MoviesRepository {
  const MoviesRepository({
    required this.service,
  });
  final MoviesService service;

  Future<GenerateMoviesLikedResponse> getMoviesLiked(
          GenerateMoviesLikedRequest request) async =>
      service.getMoviesLiked(request);

  Future<GenerateMoviesRecommandedResponse> getMoviesRecommanded(
          GenerateMoviesRecommandedRequest request) async =>
      service.getMoviesRecommanded(request);

  Future<GenerateMoviesSavedResponse> getMoviesSaved(
          GenerateMoviesSavedRequest request) async =>
      service.getMoviesSaved(request);
}
