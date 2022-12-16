/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getout/models/flex_size.dart';
import 'package:getout/models/requests/generate_movies.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.movies}) : super(key: key);

  final GenerateMoviesResponse movies;

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

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(viewportFraction: 0.2, initialPage: 0);
    bool isLandscape = (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: Column(
          children: [
            const Text("Vos recomandations,",
                textScaleFactor: 3),
            const Text("Films",
                textScaleFactor: 1.5),
            Expanded(child: PageView(
              scrollBehavior: AppScrollBehavior(),
              controller: pageController,
              allowImplicitScrolling: true,
              scrollDirection: Axis.horizontal,
              children: [
                 for (var moviePreview in widget.movies)
                    Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                              Image.network('https://image.tmdb.org/t/p/w600_and_h900_bestv2${moviePreview.posterPath}', height: 300),
                              Text(moviePreview.title,textScaleFactor: 0.9),
                      ])
                    )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
