/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import "package:flutter/material.dart";
import 'package:getout/models/requests/generate_movies.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.movies}) : super(key: key);

  final GenerateMoviesResponse movies;

  @override
  State<DashboardPage> createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { return <Widget>[]; } ,
        body: Column(
          children: [
                  PageView(
//                      controller: ,
                      allowImplicitScrolling: true,
                      children: [
                            Row(
                              children: [
//                                Image.network(widget.),
                                Column(
                                )
                              ],
                            )
                      ],
                  ),
                  SizedBox(
                  height: 300,
                  width: 300,
                  child: const DecoratedBox(
                  decoration: const BoxDecoration(
                  color: Colors.red
                  ),
                  )
                  ),
                SizedBox(
                    height: 300,
                    width: 300,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Colors.green
                      ),
                    )
                ),
                SizedBox(
                    height: 300,
                    width: 300,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Colors.purple
                      ),
                    )
                ),
                SizedBox(
                    height: 300,
                    width: 300,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Colors.yellow
                      ),
                    )
                ),
                SizedBox(
                    height: 300,
                    width: 300,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                          color: Colors.pinkAccent
                      ),
                    )
                ),
          ],
        ),
      ),
     );
  }
}
