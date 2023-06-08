/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/


import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:GetOut/models/requests/generate_movies.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage(this.movie);

  final MoviePreview movie;
  //  required this.movie

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.movie.posterPath}';
    // bool isLandscape = (MediaQuery.of(context).size.width >
    //     MediaQuery.of(context).size.height);
  Widget buildCoverImage() => Container(
          child:
          Image.network(
          imageUrl,
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
          colorBlendMode: BlendMode.modulate,
          width: double.infinity,
          fit: BoxFit.cover,
          height: 200,
        ));

  Widget buildLittleImage() => Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
                imageUrl,
                height: 300))
  );
    return Scaffold(
      body: Column(children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
         children: [
        buildCoverImage(),
        Positioned(
          top: 100,
          child: buildLittleImage(),)
          // Text(widget.movie.title, textScaleFactor: 0.9),
         ],
         ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(children: [
                          
                    ]),
            ),
            )
          ],
        ),
      ]
    )
    );
  }
}