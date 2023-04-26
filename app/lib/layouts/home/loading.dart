/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/layouts/home/dashboard.dart';
import 'package:getout/models/requests/generate_movies.dart';
import 'package:getout/models/flex_size.dart';
import 'package:getout/services/requests/requests_service.dart';

import 'dart:math';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key}) : super(key: key);
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
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    bool isLandscape = (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      GenerateMoviesRequest request = GenerateMoviesRequest(genres: [
        widget.genre[Random().nextInt(19)],
        widget.genre[Random().nextInt(19)]
      ]);
      RequestsService.instance
          .generateMovies(request)
          .then((GenerateMoviesResponse moviesResponse) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardPage(
                      movies: moviesResponse,
                    )));
      });
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[];
          },
          body: Column(children: [
            SizedBox(height: perHeight(context, (isLandscape ? 25 : 30))),
            Row(children: [
              SizedBox(width: perWidth(context, (isLandscape ? 25 : 10))),
              SizedBox(
                  height: uniHeight(context, 13, isLandscape),
                  width: uniWidth(context, 27, isLandscape),
                  child: Image.asset('assets/GetOut_logo.png')),
              SizedBox(width: perWidth(context, 4)),
              SizedBox(
                  height: uniHeight(context, 10, isLandscape),
                  width: uniWidth(context, 45, isLandscape),
                  child: Image.asset('assets/GetOut_text.png'))
            ]),
            SizedBox(height: perHeight(context, (isLandscape ? 8 : 8))),
            const SizedBox(
              height: 85,
              width: 85,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            )
          ]),
        ));
  }
}
