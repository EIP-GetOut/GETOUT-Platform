/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:boxicons/boxicons.dart';

import 'package:getout/screens/movie/pages/movie_description.dart';
import 'package:getout/screens/movie/bloc/movie_bloc.dart';

class MovieSuccessWidget extends StatelessWidget {
  const MovieSuccessWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final InfoMovieResponse movie;

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.posterPath}';
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

    return Column(children: [
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
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 250, right: 340),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))),
        ],
      ),
      Text(
        movie.title ?? '',
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
          const SizedBox(width: 15),
          const SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 10,
                // color: Colors.black,
                thickness: 0,
                // height : double.infinity,
              )),
          Text(movie.duration ?? '',
              // widget.movie.duration,
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(movie.overview ?? 'Aucune description disponible',
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
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
                  builder: (context) => MovieDescriptionPage(movie: movie)));
        },
        child: const Text(
          'voir plus >',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
