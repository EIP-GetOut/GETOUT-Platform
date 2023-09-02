import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/pages/dashboard.dart';
import 'package:getout/screens/home/bloc/movies/movies_bloc.dart';
import 'package:getout/screens/home/bloc/books/books_bloc.dart';
import 'package:getout/screens/home/bloc/dashboard/dashboard_service.dart';
import 'package:getout/screens/home/bloc/dashboard/dashboard_repository.dart';
import 'package:getout/global.dart';
import 'package:getout/tools/map_box_movie_values_to_ids.dart';

//ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  List<int> genreMoviesIds = mapBoxMovieValuesToIds(boxMovieValue);
  List<int> genreBooksIds = mapBoxMovieValuesToIds(boxBookValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => DashboardRepository(service: DashboardService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MoviesBloc>(
              create: (context) => MoviesBloc(
                dashboardRepository: context.read<DashboardRepository>(),
              )..add(
                  GenerateMoviesRequest(genres: genreMoviesIds),
                ),
            ),
            BlocProvider<BooksBloc>(
              create: (context) => BooksBloc(
                dashboardRepository: context.read<DashboardRepository>(),
              )..add(
                  GenerateBooksRequest(genres: genreBooksIds),
                ),
            ),
          ],
          child: const DashboardLayout(),
        ),
      ),
    );
  }
}
