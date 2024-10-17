/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/constants/extern_url.dart';

import 'package:getout/screens/home/bloc/liked_movies/liked_movies_bloc.dart';
import 'package:getout/screens/home/bloc/saved_movies/saved_movies_bloc.dart';
import 'package:getout/screens/home/bloc/watched_movies/watched_movies_bloc.dart';
import 'package:getout/screens/movie/bloc/movie_provider.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/tag.dart';

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
            title: appL10n(context)!.movie_recommendations,
            isBooks: false),
        const SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
          ),
          items: movies.map((movie) {
            return Builder(builder: (BuildContext context) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<LikedMoviesHydratedBloc>(
                                    context),
                                child: BlocProvider.value(
                                    value: BlocProvider.of<
                                        SavedMoviesHydratedBloc>(context),
                                    child: BlocProvider.value(
                                        value: BlocProvider.of<
                                            WatchedMoviesHydratedBloc>(context),
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
                          Align(
                              child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
//                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ///title
                                  Text(movie.title,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          overflow: TextOverflow.ellipsis)),
                                  const SizedBox(height: 4),

                                  ///averageRating + releaseDate
                                  Row(children: [
                                    if (movie.averageRating != null) ...[
                                      const Icon(Icons.star_outlined,
                                          color: Colors.white, size: 20),
                                      Text(movie.averageRating!.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                          )),
                                    ],
                                    if (movie.averageRating != null &&
                                        movie.releaseDate != null) ...[
                                      const SizedBox(width: 4),
                                      const Icon(Icons.circle,
                                          color: Colors.white, size: 5),
                                      const SizedBox(width: 4),
                                    ],
                                    if (movie.releaseDate != null)
                                      Text(movie.releaseDate!.substring(0, 4),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                          )),
                                  ]),

                                  ///movieGenres
                                  if (movie.genres != null &&
                                      movie.genres!.isNotEmpty)
                                    Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Wrap(
                                          spacing: 8.0,
                                          runSpacing: 4.0,
                                          children: movie.genres!
                                              .map((tag) => Tag(text: tag))
                                              .toList(),
                                        )),
                                ]),
                          )),
                        ],
                      )));
            });
          }).toList(),
        ),
      ],
    ));
  }
}
