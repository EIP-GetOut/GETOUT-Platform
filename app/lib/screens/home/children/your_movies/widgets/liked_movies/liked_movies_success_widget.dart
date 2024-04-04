/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

// import 'package:getout/screens/home/widgets/common/movie_preview_widget.dart';
import 'package:getout/screens/movie/bloc/movie_provider.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';

class LikedMoviesSuccessWidget extends StatelessWidget {
  const LikedMoviesSuccessWidget({
    super.key,
    required this.movies,
  });

  final List<MoviePreview> movies;

  @override
  Widget build(BuildContext context) {
    final PageController movieController =
    PageController(viewportFraction: 0.1, initialPage: 0);

    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'heart', title: 'Vos coup de coeurs'),
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
                      // child: MoviePreviewWidget(
                      //     posterPath: movies[index].posterPath,
                      //     title: movies[index].title,
                      //     overview: movies[index].overview)
                          );
                }))),
      ],
    ));
  }
}
