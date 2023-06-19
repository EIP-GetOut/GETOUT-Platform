/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:getout/models/requests/generate_movies.dart';
import 'package:getout/layouts/movie/movie.dart';
import 'package:getout/layouts/home/load.dart';
import 'package:getout/services/requests/requests_service.dart';

import 'dart:math';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  GenerateMoviesResponse movies = [];
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
  State<DashboardPage> createState() => _DashboardPageState();
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class _DashboardPageState extends State<DashboardPage> {
  bool isLoading = true;

  Future<void> getMovies() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GenerateMoviesRequest request = GenerateMoviesRequest(genres: [
        widget.genre[Random().nextInt(19)],
        widget.genre[Random().nextInt(19)]
      ]);
      RequestsService.instance
          .generateMovies(request)
          .then((GenerateMoviesResponse moviesResponse) {
        setState(() {
          isLoading = false;
        });
        widget.movies = moviesResponse;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(viewportFraction: 0.2, initialPage: 0);

    if (isLoading && widget.movies.isEmpty) {
      getMovies();
    }
    if (!isLoading && widget.movies.isEmpty) {
      // return ErrorPage(); // TODO: change to error page
    }
    return isLoading
        ? const LoadPage()
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[];
              },
              body: Column(
                children: [
                  const Text('Vos recomandations,', textScaleFactor: 3),
                  const Text('Films', textScaleFactor: 1.5),
                  Expanded(
                      child: PageView(
                    scrollBehavior: AppScrollBehavior(),
                    controller: pageController,
                    allowImplicitScrolling: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var moviePreview in widget.movies)
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailsPage(moviePreview)));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(children: [
                                  Image.network(
                                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2${moviePreview.posterPath}',
                                      height: 300),
                                  Text(moviePreview.title,
                                      textScaleFactor: 0.9),
                                ])))
                    ],
                  )),
                ],
              ),
            ),
          );
  }
}
