/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/liked_movies/liked_movies_bloc.dart';
import 'package:getout/screens/home/bloc/movies/movies_event.dart';
import 'package:getout/screens/home/bloc/saved_movies/saved_movies_bloc.dart';
import 'package:getout/screens/home/bloc/watched_movies/watched_movies_bloc.dart';
import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';

class ActionsPageMovie extends StatelessWidget {
  const ActionsPageMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = context.read<MovieBloc>().state.movie;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
          child: SizedBox(
              width: double.infinity,
              // height: 200,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (movie.seen == true) {
                          await context.read<MovieBloc>()
                              .movieService
                              .removeSeenMovie(
                              AddMovieRequest(id: movie.id!));
                        } else {
                          await context
                              .read<MovieBloc>()
                              .movieService
                              .addSeenMovie(
                              AddMovieRequest(id: movie.id!));
                        }
                        if (!context.mounted) return;
                        context.read<MovieBloc>().add(CreateInfoMovieRequest(id: movie.id!));
                        context.read<WatchedMoviesHydratedBloc>().add(const GenerateMoviesRequest());
                        showCustomSnackBar(
                            context: context,
                            color: Colors.green,
                            message: 'Le film a bien été ${movie.seen == false ?'ajouté à': 'retiré de'} vos films à voir',
                            icon: Icons.check_circle_rounded);
                        //watch
                        Navigator.pop(context);
                      },
                      highlightColor: Colors.grey.withOpacity(0.1),
                      child: Row(children: [
                        const Icon(Icons.remove_red_eye, size: 30),
                        const SizedBox(
                          width: 10,
                        ), // Icons.visibility_off
                        Text(
                            movie.seen != null && movie.seen!
                                ? appL10n(context)!.remove_seen
                                : appL10n(context)!.add_seen,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500))
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          if (movie.liked == true) {
                            await context
                                .read<MovieBloc>()
                                .movieService
                                .removeLikedMovie(
                                AddMovieRequest(id: movie.id!));
                          } else {
                            await context
                                .read<MovieBloc>()
                                .movieService
                                .addLikedMovie(
                                AddMovieRequest(id: movie.id!));
                          }
                          if (!context.mounted) return;
                          context.read<MovieBloc>().add(CreateInfoMovieRequest(id: movie.id!));
                          context.read<LikedMoviesHydratedBloc>().add(const GenerateMoviesRequest());
                          showCustomSnackBar(
                              context: context,
                              color: Colors.green,
                              message: 'Le film a bien été ${movie.liked == false ?'ajouté à': 'retiré de'} vos films aimés',
                              icon: Icons.check_circle_rounded);
                          Navigator.pop(context);
                        },
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: Row(children: [
                          const Icon(
                            Icons.favorite,
                            size: 30,
                          ), //
                          const SizedBox(
                            width: 10,
                          ), // IIcons.favorite_outlined
                          Text(
                              movie.liked != null && movie.liked!
                                  ? appL10n(context)!.dislike
                                  : appL10n(context)!.like,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500))
                        ])),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
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
                              .addWishListedMovie(
                              AddMovieRequest(id: movie.id!));
                        }
                        if (!context.mounted) return;
                        context
                            .read<MovieBloc>()
                            .add(CreateInfoMovieRequest(id: movie.id!));
                        context.read<SavedMoviesHydratedBloc>().add(const GenerateMoviesRequest());
                        showCustomSnackBar(
                            context: context,
                            color: Colors.green,
                            message: 'Le film a bien été ${movie.wishlisted == false ?'ajouté à': 'retiré de'} vos films en cours',
                            icon: Icons.check_circle_rounded);
                        Navigator.pop(context);
                      },
                      highlightColor: Colors.grey.withOpacity(0.1),
                      child: Row(children: [
                        const Icon(Icons.add_circle_outlined,
                            size: 30), // Icons.remove_circle
                        const SizedBox(
                          width: 10,
                        ), // I
                        Text(
                            movie.wishlisted != null && movie.wishlisted!
                                ? appL10n(context)!.remove_watchlist
                                : appL10n(context)!.add_watchlist,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500))
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          if (movie.disliked == false) {
                            await context
                                .read<MovieBloc>()
                                .movieService
                                .addDislikedMovie(
                                AddMovieRequest(id: movie.id!));
                          } else {
                            await context
                                .read<MovieBloc>()
                                .movieService
                                .removeDislikedMovie(
                                AddMovieRequest(id: movie.id!));
                          }
                          if (!context.mounted) return;
                          context.read<MovieBloc>().add(CreateInfoMovieRequest(id: movie.id!));
                          context.read<LikedMoviesHydratedBloc>().add(const GenerateMoviesRequest());
                          showCustomSnackBar(
                              context: context,
                              color: Colors.green,
                              message: 'Le film a bien été ${movie.disliked == false ?'retiré de': 'restituer à'} vos prochaines recommendations.',
                              icon: Icons.check_circle_rounded);
                          Navigator.pop(context);
                        },
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: Row(children: [
                          const Icon(
                            Icons.block_outlined,
                            size: 30,
                          ), // Icons.check_circle_rounded
                          const SizedBox(
                            width: 10,
                          ), // I
                          Text(
                              movie.disliked != null && movie.disliked!
                                  ? appL10n(context)!.interested
                                  : appL10n(context)!.not_interested,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500))
                        ]))
                  ]))),
    );
  }
}
