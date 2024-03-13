/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/screens/movie/bloc/movie_service.dart';
import 'package:getout/screens/movie/bloc/movie_bloc.dart';

class MovieRepository {
  const MovieRepository({
    required this.service,
  });
  final MovieService service;

  Future<InfoMovieResponse> getInfoMovie(
          CreateInfoMovieRequest request) async =>
      service.getInfoMovie(request);

  Future<AddLikeMovieResponse> addLikeMovie(
          AddLikeMovieRequest request) async =>
      service.addLikeMovie(request);
}
