/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/movies/widgets/common/title.dart';
import 'package:getout/screens/movies/widgets/common/poster_and_description.dart';
import 'package:getout/screens/movies/bloc/movies_saved/movies_saved_bloc.dart';
import 'package:getout/screens/movie/bloc/movie_provider.dart';

class MoviesSavedSuccessWidget extends StatelessWidget {
  MoviesSavedSuccessWidget({
    super.key,
    required this.movies,
  });

  final List<MovieSavedPreview> movies;

  final PageController movieController =
      PageController(viewportFraction: 0.1, initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'party_emoji', title: 'Vos films en cours'),
        Expanded(
            child: ListView(
                controller: movieController,
                scrollDirection: Axis.horizontal,
                children: List.generate(movies.length, (index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Movie(movies[index].id)));
                      },
                      child: PosterAndDescriptionWidget(
                          posterPath: movies[index].posterPath,
                          title: movies[index].title,
                          overview: movies[index].overview));
                }))),
      ],
    ));
  }
}
