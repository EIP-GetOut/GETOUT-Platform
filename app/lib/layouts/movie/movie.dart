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
import 'package:getout/models/requests/info_movie.dart';
import 'package:getout/layouts/home/load.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/constants/http_status.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage(this.movie, {super.key});

  final MoviePreview movie;
  //  required this.movie

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool isLoading = true;
  InfoMovieResponse? infoMovie;
  final HttpStatus httpStatus = HttpStatus({
    HttpStatus.INTERNAL_SERVER_ERROR:
    'Une erreur s\'est produite, veuillez réesayer plus tard',
    HttpStatus.NO_INTERNET: 'Pas de connexion internet',
  });

  getMovieInfo() async {
    InfoMovieResponse res = await RequestsService.instance
        .getInfoMovie(CreateInfoMovieRequest(id: widget.movie.id));
    if (res.statusCode == InfoMovieResponse.success) {
      infoMovie = res;
    }
    setState(() {
      isLoading = false;
    });
  }

  paBoError() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Une erreur s\'est produite, veuillez réesayer plus tard'),
        backgroundColor: Color.fromARGB(255, 239, 46, 46)));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && infoMovie == null) {
      getMovieInfo();
      return const LoadPage();
    }
    if (isLoading == false && infoMovie == null) {
      paBoError();
      Navigator.pop(context, true);
      return const LoadPage();
    }
    String imageUrl =
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${infoMovie?.posterPath}';
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
        extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 213, 86, 65),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        ),
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
        infoMovie?.title ?? '',
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
          Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment
            .center, //Center Row contents vertically,            children: [
        children: [
          const Text('Film',
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 10,
                // color: Colors.black,
                thickness: 0,
                // height : double.infinity,
              )),
          Text(infoMovie?.duration ?? '',
              // widget.movie.duration,
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(infoMovie?.overview ?? 'No description available',
                textAlign: TextAlign.justify,
                textScaleFactor: 0.9,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'Urbanist',
                )),
          ),
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
