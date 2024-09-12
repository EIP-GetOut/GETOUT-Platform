/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/constants/extern_url.dart';

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
    //final PageController movieController =
    //    PageController(viewportFraction: 0.1, initialPage: 0);

    return SizedBox(
        child: Column(
          children: [
            TitleWidget(
                asset: 'fire',
                title: appL10n(context)!.movie_recommendations),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 250.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                aspectRatio: 1.0,
                enlargeCenterPage: true,
              ),
              items: movies.map((movie) {
                return Builder(builder: (BuildContext context) {
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
                                            child: Movie(movie.id))))));
                      },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${ExternalConstants.MovieImagePreviewPath}${movie.posterPath!}')),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Clip it cleanly.

                            child: Container(
                                color: Colors.black.withOpacity(0.4),
                                alignment: Alignment.center,
                            ),
                          ),
                          /*Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${ExternalConstants.MovieImagePreviewPath}${movie.posterPath!}')),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Colors.blue,
                              ),
                            ),
                          ),*/
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
//                                mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(movie.title,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              overflow: TextOverflow.ellipsis)),
                                      const SizedBox(height: 10),
                                      /*const Row(children: [
                                        Icon(Icons.star_outlined,
                                            color: Colors.white, size: 20),
                                        Text('5.0',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                            )),
                                        SizedBox(width: 4),
                                        Icon(Icons.circle,
                                            color: Colors.white, size: 5),
                                        SizedBox(width: 4),
                                        Text('2000',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                            )),
                                      ]),*/
                                    ]),
                              )),
                        ],
                      )));
                });
              }).toList(),
            ),
            /*Expanded(
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
                    }))),*/
          ],
        ));
  }
}
