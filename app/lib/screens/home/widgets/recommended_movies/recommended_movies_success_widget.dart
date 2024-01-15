/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/widgets/common/movie_preview_widget.dart';

import 'package:getout/screens/movie/bloc/movie_provider.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';

class RecommendedMoviesSuccessWidget extends StatelessWidget {
  final List<MoviePreview> movies;
  final PageController movieController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  RecommendedMoviesSuccessWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'fire_emoji', title: 'Nous recommandons pour vous'),
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
