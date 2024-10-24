/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
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

class SavedMoviesSuccessWidget extends StatelessWidget {
  const SavedMoviesSuccessWidget({
    super.key,
    required this.movies,
  });

  final List<MoviePreview> movies;

  @override
  Widget build(BuildContext context) {
    final PageController movieController =
        PageController(viewportFraction: 0.1, initialPage: 0);
    return SizedBox(
        height: 300,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TitleWidget(
                asset: 'party',
                title: 'Les films que vous voulez voir',
                length: movies.length,
                isBooks: false),
            const SizedBox(height: 20),
            movies.isNotEmpty
                ? Expanded(
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
                                        value: BlocProvider.of<
                                            LikedMoviesHydratedBloc>(context),
                                        child: BlocProvider.value(
                                            value: BlocProvider.of<
                                                    SavedMoviesHydratedBloc>(
                                                context),
                                            child: BlocProvider.value(
                                                value: BlocProvider.of<
                                                        WatchedMoviesHydratedBloc>(
                                                    context),
                                                child: Movie(movies[index].id))))));
                          },
                          child: MoviePreviewWidget(
                              posterPath: movies[index].posterPath,
                              title: movies[index].title));
                    })))
                : const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                    'Ajoutez de nouveaux films a votre liste pour les voir afficher ici',
                    maxLines: 2,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                    )))
          ],
        ));
  }
}
