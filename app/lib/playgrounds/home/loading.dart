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
import 'package:getout/playgrounds/home/dashboard.dart';

import 'package:getout/models/requests/generate_movies.dart';
import 'package:getout/services/requests/requests_service.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();

/*  List<Content> lc;
  GenerateMoviesRequest request = GenerateMoviesRequest(withGenres: '37, 45');
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
            RequestsService.instance
                .generateMovies(request)
                .then(
                    (GenerateMoviesResponse moviesResponse) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage(movies: moviesResponse,)));
                }
            );
        }
    );
  }*/
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { return <Widget>[]; } ,
        body: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Colors.blue,
        ),
      ),
    );
  }
}
