/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import "package:flutter/material.dart";
import 'package:getout/constants/movie_genre.dart';
import 'package:getout/playgrounds/home/dashboard.dart';

import 'package:getout/models/requests/generate_movies.dart';
import 'package:getout/services/requests/requests_service.dart';

import 'dart:math';

void toto() {

}
class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key}) : super(key: key);
  List<int> genre = [28,12,16,35,80,99,18,10751,14,36,27,10402,9648,10749,878,10770,53,10752,37];

  @override
  State<LoadingPage> createState() => _LoadingPageState();

}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GenerateMoviesRequest request = GenerateMoviesRequest(genres: [widget.genre[Random().nextInt(19)], widget.genre[Random().nextInt(19)]]);
      RequestsService.instance.generateMovies(request).then((GenerateMoviesResponse moviesResponse) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardPage(
                      movies: moviesResponse,
                    )));
      });
    });
    return Scaffold(
      backgroundColor: Colors.red,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Colors.blue,
        ),
      ),
    );
  }
}
