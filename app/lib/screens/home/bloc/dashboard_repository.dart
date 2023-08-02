/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/screens/home/bloc/dashboard_service.dart';
import 'package:getout/screens/home/bloc/movie_bloc.dart';

class DashboardRepository {
  const DashboardRepository({
    required this.service,
  });
  final DashboardService service;

  Future<GenerateMoviesResponse> getMovies(
          GenerateMoviesRequest request) async =>
      service.getMovies(request);

  // Future<List<Genre>> getGenres() async => service.getGenres();

  // Future<List<Result>> getGamesByCategory(int genreId) async =>
  //     service.getGamesByCategory(genreId);
}
