/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/widgets/common/title.dart';
import 'package:getout/screens/home/widgets/common/poster_and_desription.dart';
import 'package:getout/screens/home/bloc/movies/movies_bloc.dart';
import 'package:getout/screens/movie/bloc/movie_provider.dart';

class MoviesSuccessWidget extends StatelessWidget {
  MoviesSuccessWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<MoviePreview> movies;

  final PageController movieController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'popcorn_emoji', title: 'Les films que vous allez aimer'),
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
