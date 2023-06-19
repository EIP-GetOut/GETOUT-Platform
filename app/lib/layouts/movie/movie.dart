/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/layouts/movie/movie_description.dart';
import 'package:flutter/material.dart';
import 'package:boxicons/boxicons.dart';
import 'package:getout/models/requests/generate_movies.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage(this.movie, {super.key});

  final MoviePreview movie;
  //  required this.movie

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.movie.posterPath}';
    // bool isLandscape = (MediaQuery.of(context).size.width >
    //     MediaQuery.of(context).size.height);
    Widget buildCoverImage() => Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(213, 86, 65, 0.992),
                width: 10.0,
              ),
            ),
          ),
          child: Image.network(
            imageUrl,
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
            colorBlendMode: BlendMode.modulate,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 200,
          ),
        );

    Widget buildLittleImage() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(imageUrl, height: 250));

    return Scaffold(
        body: Column(children: [
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 150),
            child: buildCoverImage(),
          ),
          Positioned(
            top: 100,
            child: buildLittleImage(),
          ),
        ],
      ),
      Text(
        widget.movie.title,
        textScaleFactor: 0.9,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment
            .center, //Center Row contents vertically,            children: [
        children: [
          Icon(
            Boxicons.bx_movie,
            size: 40,
          ),
          SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 30,
                color: Colors.black,
                thickness: 1,
                // heigth : double.infinity,
              )),
          Icon(Boxicons.bx_time, size: 40),
        ],
      ),
      const Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment
            .center, //Center Row contents vertically,            children: [
        children: [
          Text('Film',
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 10,
                // color: Colors.black,
                thickness: 0,
                // heigth : double.infinity,
              )),
          Text('A METTRE',
              // widget.movie.duration,
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
      const Text(
        'A METTRE',
        // widget.movie.overview,
        // textScaleFactor: 0.9,
        // textAlign: TextAlign.center,
        // style: TextStyle(
        // fontSize: 22,
        // fontWeight: FontWeight.bold
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MovieDescriptionPage()));
        },
        child: const Text(
          'voir plus >',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    ]));
  }
}
