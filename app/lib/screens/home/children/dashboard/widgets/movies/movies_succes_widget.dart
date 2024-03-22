/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/widgets/common/movie_preview_widget.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';

import 'package:getout/screens/movie/bloc/movie_provider.dart';

class MoviesSuccessWidget extends StatelessWidget {
  final List<MoviePreview> movies;

  const MoviesSuccessWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final PageController movieController =
    PageController(viewportFraction: 0.1, initialPage: 0);

    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'popcorn', title: 'Les films que vous allez aimer'),
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
                      child: MoviePreviewWidget(
                          posterPath: movies[index].posterPath,
                          title: movies[index].title,
                          overview: movies[index].overview));
                }))),
      ],
    ));
  }
}
