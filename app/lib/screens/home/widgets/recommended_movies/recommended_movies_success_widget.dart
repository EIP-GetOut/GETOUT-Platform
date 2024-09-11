/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/home/bloc/liked_movies/liked_movies_bloc.dart';
import 'package:getout/screens/home/bloc/saved_movies/saved_movies_bloc.dart';
import 'package:getout/screens/home/bloc/watched_movies/watched_movies_bloc.dart';

import 'package:getout/screens/home/widgets/common/movie_preview_widget.dart';
import 'package:getout/screens/movie/bloc/movie_provider.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';
import 'package:getout/tools/app_l10n.dart';

class RecommendedMoviesSuccessWidget extends StatelessWidget {
  final List<MoviePreview> movies;

  const RecommendedMoviesSuccessWidget({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final PageController movieController =
    PageController(viewportFraction: 0.1, initialPage: 0);

    return SizedBox(
      height: 300,
        child: Column(
      children: [
        TitleWidget(
            asset: 'fire', title: appL10n(context)!.movie_recommendations, length: movies.length),
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
                                builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<LikedMoviesHydratedBloc>(context),
                                    child: BlocProvider.value(
                                        value: BlocProvider.of<SavedMoviesHydratedBloc>(context),
                                        child: BlocProvider.value(
                                            value: BlocProvider.of<WatchedMoviesHydratedBloc>(context),
                                            child: Movie(movies[index].id))))));
                      },
                      child: MoviePreviewWidget(
                          posterPath: movies[index].posterPath,
                          title: movies[index].title));
                }))),
      ],
    ));
  }
}
