/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:getout/layouts/settings/settings.dart';
import 'package:getout/layouts/settings/edit_password.dart';
import 'package:getout/models/requests/generate_movies.dart';
import 'package:getout/layouts/movie/movie.dart';
import 'package:getout/layouts/home/load.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/global.dart';

import '../../models/requests/generate_books.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  GenerateMoviesResponse movies = [];
  GenerateBooksResponse books = [];
  /*final List<int> genre = [
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
  ];*/

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
  int booksLength = 0;
  List<int> ids = mapBoxFilmValuesToIds(boxFilmValue);

  @override
  Widget build(BuildContext context) {
    PageController movieController =
        PageController(viewportFraction: 0.1, initialPage: 0);
    PageController bookController =
    PageController(viewportFraction: 0.1, initialPage: 0);

    if (isLoading && widget.movies.isEmpty) {
      getMovies();
      getBooks();
      return const LoadPage();
    }
    if (!isLoading && widget.movies.isEmpty) {
      // return ErrorPage(); // TODO: change to error page
      return const LoadPage();
    }
    booksLength = widget.books.length;
    return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
                children: [
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const ParametersPage()));
                        },
                        child: Image.asset(
                          'assets/Profile_picture.png',
                          width: 60,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bienvenue !', style: Theme.of(context).textTheme.titleMedium),
                          Text('La productivité à portée de main', style: Theme.of(context).textTheme.displayMedium)
                        ],
                      ),
                      const SizedBox(width: 25),
                          Image.asset(
                            'assets/GetOut_logo.png',
                            width: 40,
                          ),
                    ],),
                  const SizedBox(height: 35),
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
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView(
                    controller: movieController,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(5, (index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetailsPage(widget.movies[index])));
                            },
                            child: Container(
                                margin: const EdgeInsets.all(10.0),
                              width: 100,
                              child: Column(
                                  children: [
                                      ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.movies[index].posterPath}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(widget.movies[index].title, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold)),
                                      ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(right: 13.0),
                                        child: Text(widget.movies[index].overview ?? 'Aucune description disponible',
                                            textAlign: TextAlign.justify,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style: Theme.of(context).textTheme.bodySmall),
                                      ),
                                    ),
                                  ]),
                            ),
                        );
                    }))),
            Row(
              children: [
                const SizedBox(width: 10),
                Image.asset(
                  'assets/books_emoji.png',
                ),
                const SizedBox(width: 10),
                const Text('Les livres qui vous passionneront', style: TextStyle(
                  color: Color(0xFFD55641),
                  fontSize: 23,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                )),
              ],
            ),
        Expanded(
            child: ListView(
                controller: bookController,
                scrollDirection: Axis.horizontal,
                children: List.generate(booksLength, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsPage(widget.movies[index])));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 100,
                      child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                widget.books[index].posterPath ?? 'https://media.istockphoto.com/id/1392182937/vector/no-image-available-photo-coming-soon.jpg?s=612x612&w=0&k=20&c=3vGh4yj0O2b4tPtjpK-q-Qg0wGHsjseL2HT-pIyJiuc=',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(widget.books[index].title, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(right: 13.0),
                                child: Text(widget.books[index].overview ?? 'Aucune description disponible',
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: Theme.of(context).textTheme.bodySmall),
                              ),
                            ),
                          ]),
                    ),
                  );
                })))
                ]));
  }

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

  Future<void> getBooks() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GenerateBooksRequest request = GenerateBooksRequest(genres: ['drama']);
      RequestsService.instance
          .generateBooks(request)
          .then((GenerateBooksResponse booksResponse) {
        setState(() {
          isLoading = false;
        });
        widget.books = booksResponse;
      });
    });
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
    if (boxFilmValue.every((value) => value == false)) {
    ids.add(35);
  }
  return ids;
}
