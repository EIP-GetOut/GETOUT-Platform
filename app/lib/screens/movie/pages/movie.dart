/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:boxicons/boxicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/movie/pages/movie_description.dart';
import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/tools/app_l10n.dart';

import 'package:getout/tools/duration_format.dart';

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
                color: const Color.fromRGBO(150, 150, 150, 255).withOpacity(1),
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
                  color: (movie.seen ?? false) ? Colors.green : Colors.white,
                  onPressed: () async {
                    if (movie.seen == true) {
                      await context
                          .read<MovieBloc>()
                          .movieService
                          .removeSeenMovie(AddMovieRequest(id: movie.id!));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieService
                          .addSeenMovie(AddMovieRequest(id: movie.id!));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id!));
                  },
                ),
              ),
              Positioned(
                top: 30,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.thumb_up_alt_sharp),
                  color: (movie.liked ?? false) ? Colors.green : Colors.white,
                  onPressed: () async {
                    if (movie.liked == true) {
                      await context
                          .read<MovieBloc>()
                          .movieService
                          .removeLikedMovie(AddMovieRequest(id: movie.id!));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieService
                          .addLikedMovie(AddMovieRequest(id: movie.id!));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id!));
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
                          .movieService
                          .removeDislikedMovie(AddMovieRequest(id: movie.id!));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieService
                          .addDislikedMovie(AddMovieRequest(id: movie.id!));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id!));
                  },
                ),
              ),
              Positioned(
                top: 130,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.add_circle_outlined),
                  color:
                      (movie.wishlisted ?? false) ? Colors.green : Colors.white,
                  onPressed: () async {
                    if (movie.wishlisted == true) {
                      await context
                          .read<MovieBloc>()
                          .movieService
                          .removeWishListedMovie(
                              AddMovieRequest(id: movie.id!));
                    } else {
                      await context
                          .read<MovieBloc>()
                          .movieService
                          .addWishListedMovie(AddMovieRequest(id: movie.id!));
                    }
                    if (!context.mounted) return;
                    context
                        .read<MovieBloc>()
                        .add(CreateInfoMovieRequest(id: movie.id!));
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
                      color: Color.fromARGB(255, 255, 255, 255),
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
      // const Row(
      //   mainAxisAlignment:
      //       MainAxisAlignment.center, //Center Row contents horizontally,
      //   crossAxisAlignment: CrossAxisAlignment
      //       .center, //Center Row contents vertically,            children: [
      //   children: [
      //     Icon(
      //       Boxicons.bx_movie,
      //       size: 40,
      //     ),
      //     SizedBox(
      //         height: 20,
      //         child: VerticalDivider(
      //           width: 30,
      //           color: Colors.black,
      //           thickness: 1,
      //           // heigth : double.infinity,
      //         )),
      //     Icon(Boxicons.bx_time, size: 40),
      //   ],
      // ),
      Row(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment
              .center, //Center Row contents vertically,            children: [
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star, // Icône d'étoile
                ),
                SizedBox(width: 5), // Espacement entre l'icône et le texte
                Text(
                  movie.voteAverage != null
                      ? movie.voteAverage.toString()
                      : 'N/A', // Le nombre à afficher à côté de l'étoile
                  style: TextStyle(
                    fontSize: 16, // Taille du texte
                    fontWeight: FontWeight.bold, // Poids du texte
                  ),
                ),
                // Text(movie.voteAverage),
              ],
            ),
            Text(durationFormat('', movie.duration ?? 0),
                // widget.movie.duration,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall),
            Text(movie.releaseDate ?? ''),
          ]),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(movie.overview ?? appL10n(context)!.no_description,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
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
        child: Text(
          appL10n(context)!.see_more,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
