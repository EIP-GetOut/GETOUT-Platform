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
import 'package:getout/tools/app_l10n.dart';

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
        TitleWidget(
            asset: 'popcorn', title: appL10n(context)!.movie_recommendations),
        const Padding(padding: EdgeInsets.only(top: 10)),
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
                      child: MoviePreviewWidget(
                          posterPath: movies[index].posterPath,
                          title: movies[index].title,
                          ));
                }))),
      ],
    ));
  }
}
