/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:boxicons/boxicons.dart';

import 'package:getout/screens/movie/pages/movie_description.dart';
import 'package:getout/screens/movie/bloc/movie_bloc.dart';

import 'package:getout/tools/format_spend_times.dart';

class MovieSuccessWidget extends StatelessWidget {
  const MovieSuccessWidget({
    super.key,
    required this.movie,
  });

  final InfoMovieResponse movie;

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.posterPath}';
    Widget buildCoverImage() => Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(213, 86, 65, 0.992),
                width: 10.0,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                imageUrl,
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
                colorBlendMode: BlendMode.modulate,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
              ),
              Positioned(
                top: 30,
                right: 140,
                child: IconButton(
                  icon: const Icon(Icons.share),
                  color: Colors.white,
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                        text: 'https://www.themoviedb.org/movie/${movie.id}'));
                  },
                ),
              ),
              Positioned(
                top: 30,
                right: 80,
                child: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  color: (movie.seen ?? false) ? Colors.red : Colors.white,
                  onPressed: () async {
                    if (movie.seen == true) {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .removeSeenMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .addSeenMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id ?? -1));
                  },
                ),
              ),
              Positioned(
                top: 30,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.thumb_up_alt_sharp),
                  color: (movie.liked ?? false) ? Colors.red : Colors.white,
                  onPressed: () async {
                    if (movie.liked == true) {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .removeLikedMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .addLikedMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id ?? -1));
                  },
                ),
              ),
              Positioned(
                top: 80,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.thumb_down),
                  color: (movie.disliked ?? false) ? Colors.red : Colors.white,
                  onPressed: () async {
                    if (movie.disliked == true) {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .removeDislikedMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .addDislikedMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id ?? -1));
                  },
                ),
              ),
              Positioned(
                top: 130,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.add_circle_outlined),
                  color:
                      (movie.wishlisted ?? false) ? Colors.red : Colors.white,
                  onPressed: () async {
                    if (movie.wishlisted == true) {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .removeWishlistedMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieRepository
                          .service
                          .addWishlistedMovie(
                              AddLikeMovieRequest(id: movie.id ?? -1));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id ?? -1));
                  },
                ),
              ),
            ],
          ),
        );

    Widget buildLittleImage() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(imageUrl, height: 250));

    return Column(children: [
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 150),
            child: buildCoverImage(),
          ),
          Positioned(
            top: 100,
            child: buildLittleImage(),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 250, right: 340),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ))),
        ],
      ),
      Text(
        movie.title ?? 'N/A',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment
            .center, //Center Row contents vertically,            children: [
        children: [
          Icon(
            Boxicons.bx_movie,
            size: 40,
          ),
          SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 30,
                color: Colors.black,
                thickness: 1,
                // heigth : double.infinity,
              )),
          Icon(Boxicons.bx_time, size: 40),
        ],
      ),
      Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment
            .center, //Center Row contents vertically,            children: [
        children: [
          Text('Film',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(width: 15),
          const SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 10,
                // color: Colors.black,
                thickness: 0,
                // height : double.infinity,
              )),
          Text(formatSpendTime('', movie.duration ?? 0),
              // widget.movie.duration,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(movie.overview ?? 'Aucune description disponible',
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 11,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDescriptionPage(
                movie: movie,
              ),
            ),
          );
        },
        child: const Text(
          'voir plus >',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
