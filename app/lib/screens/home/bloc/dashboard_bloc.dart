import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/pages/dashboard.dart';

import 'package:getout/screens/home/bloc/movie_bloc.dart';
import 'package:getout/screens/home/bloc/dashboard_service.dart';
import 'package:getout/screens/home/bloc/dashboard_repository.dart';

import 'dart:math';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final List<int> genre = [
    28,
    12,
    16,
    35,
    80,
    99,
    18,
    10751,
    14,
    36,
    27,
    10402,
    9648,
    10749,
    878,
    10770,
    53,
    10752,
    37
  ];

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
                  GenerateMoviesRequest(genres: [
                    genre[Random().nextInt(19)],
                    genre[Random().nextInt(19)]
                  ]),
                ),
            ),
            // BlocProvider<BooksBloc>(
            //   create: (context) => BooksBloc(
            //     gameRepository: context.read<DashboardRepository>(),
            //   )..add(
            //       GetBooks(),
            //     ),
            // ),
          ],
          child: const DashboardLayout(),
        ),
      ),
    );
  }
}
