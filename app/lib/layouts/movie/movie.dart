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

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(300.0), // here the desired height
          child: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
          title: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        scale: 0.2
                      )),
          leading: const BackButton(),
          backgroundColor: Colors.white10,
          elevation: 0,
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        Image.network(
                            imageUrl,
                            height: 300),
                        Text(widget.movie.title, textScaleFactor: 0.9),
                  ]),
          ),
          )
        ],
      ),
    );
  }
}