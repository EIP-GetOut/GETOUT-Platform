/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/movies/widgets/common/title.dart';
import 'package:getout/screens/movies/widgets/common/poster_and_desription.dart';
import 'package:getout/screens/movies/bloc/movies_liked/movies_liked_bloc.dart';
import 'package:getout/screens/movie/bloc/movie_provider.dart';

class MoviesLikedSuccessWidget extends StatelessWidget {
  MoviesLikedSuccessWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<MovieLikedPreview> movies;

  final PageController movieController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'heart_emoji', title: 'Vos coup de coeurs'),
        Expanded(
            child: ListView(
                controller: movieController,
                scrollDirection: Axis.horizontal,
                children: List.generate(5, (index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Movie(movies[index].id)));
                      },
                      child: PosterAndDescriptionWidget(
                          posterpath: movies[index].posterPath,
                          title: movies[index].title,
                          overview: movies[index].overview));
                }))),
      ],
    ));
  }
}
