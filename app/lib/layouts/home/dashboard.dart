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
import 'package:getout/global.dart';

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
  List<int> ids = mapBoxFilmValuesToIds(boxFilmValue);

  Future<void> getMovies() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GenerateMoviesRequest request = GenerateMoviesRequest(genres: ids);
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
        PageController(viewportFraction: 0.4, initialPage: 0);

    if (isLoading && widget.movies.isEmpty) {
      getMovies();
      return const LoadPage();
    }
    if (!isLoading && widget.movies.isEmpty) {
      // return ErrorPage(); // TODO: change to error page
      return const LoadPage();
    }
    return Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[];
              },
              body: Column(
                children: [
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Image.asset(
                          'assets/Profile_picture.png',
                          width: 60,
                        ),
                      const SizedBox(width: 20),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bienvenue !',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                          )),
                          Text('La productivité à portée de main', style: TextStyle(
                              color: Colors.black, fontSize: 18)),
                        ],
                      ),
                    ],),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/popcorn_emoji.png',
                      ),
                      const SizedBox(width: 10),
                      const Text('Les films que vous allez aimer', style: TextStyle(
                          color: Color(0xFFD55641),
                          fontSize: 23,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                      )),
                    ],
                  ),
                  const SizedBox(height: 15),
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
                                margin: const EdgeInsets.all(10.0),
                              child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${moviePreview.posterPath}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(moviePreview.title, style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(right: 13.0),
                                        child: const Text('Overview', style: TextStyle(
                                          color: Color(0xFFD3D3D3),
                                          fontSize: 18,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    ),
                                  ]),
                            ))
                    ],
                  )),
                ],
              ),
            ),
          );
  }
}

List<int> mapBoxFilmValuesToIds(List<bool> boxFilmValue) {
  List<int> ids = [];

  if (boxFilmValue.isNotEmpty && boxFilmValue[0]) {
    ids.add(28);
  }
  if (boxFilmValue.length >= 2 && boxFilmValue[1]) {
    ids.add(53);
  }
  if (boxFilmValue.length >= 3 && boxFilmValue[2]) {
    ids.add(37);
  }
  if (boxFilmValue.length >= 4 && boxFilmValue[3]) {
    ids.add(27);
  }
  if (boxFilmValue.length >= 5 && boxFilmValue[4]) {
    ids.add(35);
  }

  return ids;
}
