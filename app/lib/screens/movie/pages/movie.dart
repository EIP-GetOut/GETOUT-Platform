/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/bloc/watched_movies/watched_movies_bloc.dart';

import 'package:getout/widgets/description_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/home/bloc/liked_movies/liked_movies_bloc.dart';
import 'package:getout/screens/home/bloc/saved_movies/saved_movies_bloc.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/tools/app_l10n.dart';

import 'package:getout/tools/duration_format.dart';
import 'package:getout/widgets/tag.dart';
import 'package:getout/widgets/actions_page.dart';
import 'package:getout/tools/launch_webview.dart';

import 'package:share_plus/share_plus.dart';

import 'dart:ui';

class MovieSuccessWidget extends StatelessWidget {
  MovieSuccessWidget({super.key});

//  final InfoMovieResponse movie;
  final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final movie = context.read<MovieBloc>().state.movie;
    final String releaseDate = movie.releaseDate ?? '';

    String imageUrl =
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.posterPath}';

    List<Tag> tagList() {
      return movie.genres!.map((tag) => Tag(text: tag)).toList();
    }

    Widget buildCoverImage() => Container(
        decoration: const BoxDecoration(
          border: Border(
              // bottom: BorderSide(
              //   color: Color.fromRGBO(213, 86, 65, 0.992),
              //   width: 10.0,
              // ),
              ),
        ),
        child: Stack(alignment: Alignment.center, children: [
          Image.network(
            imageUrl,
            // color: const Color.fromRGBO(150, 150, 150, 255).withOpacity(1),
            colorBlendMode: BlendMode.modulate,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 200,
          ),
          Positioned.fill(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(
                  0.5), // Couleur transparente pour que le flou soit visible
            ),
          )),
          Positioned(
            top: 40,
            right: 50,
            child: IconButton(
              icon: const Icon(Icons.share),
              color: Colors.white,
              onPressed: () async {
                Share.share(
                    "Regarde ce film que j'ai trouvé grâce à Getout ! https://www.themoviedb.org/movie/${movie.id}");
              },
            ),
          ),
          Positioned(
              top: 40,
              right: 0,
              child: IconButton(
                  icon: const Icon(Icons.more_vert),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return BlocProvider.value(
                              value: BlocProvider.of<MovieBloc>(context),
                              child: BlocProvider.value(
                                  value:
                                      BlocProvider.of<LikedMoviesHydratedBloc>(
                                          context),
                                  child: BlocProvider.value(
                                      value: BlocProvider.of<
                                          SavedMoviesHydratedBloc>(context),
                                      child: BlocProvider.value(
                                          value: BlocProvider.of<
                                                  WatchedMoviesHydratedBloc>(
                                              context),
                                          child: const FractionallySizedBox(
                                              heightFactor: 0.9,
                                              child: ActionsPageMovie())))));
                        });
                  }))
        ]));

    Widget buildLittleImage() => GestureDetector(
        onTap: () =>
            launchWebView('https://www.themoviedb.org/movie/${movie.id}'),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(imageUrl, height: 300)));

    return Center(
        child: ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 220),
                          child: buildCoverImage(),
                        ),
                        Positioned(
                          top: 100,
                          child: buildLittleImage(),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 300, right: 340),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Text(
                          movie.title ?? 'N/A',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star),
                            const SizedBox(width: 2),
                            Text(
                              movie.voteAverage != null
                                  ? ((movie.voteAverage! * 10).roundToDouble() / 10).toString()
                                  : 'N/A',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          releaseDate != '' ? releaseDate.split('-')[0] : '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          durationFormat('', movie.duration ?? 0),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    movie.genres != null && movie.genres!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: tagList(),
                            ))
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: isExpanded,
                            builder: (context, isExpandedValue, child) {
                              return Column(
                                children: [
                                  Text(
                                    movie.overview ??
                                        appL10n(context)!.no_description,
                                    textAlign: TextAlign.justify,
                                    overflow: isExpandedValue
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                                    maxLines: isExpandedValue ? null : 8,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      isExpanded.value = !isExpanded.value;
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                            isExpandedValue
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 40.0),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    DescriptionTitle(value: appL10n(context)!.director),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: movie.director != null
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage(movie.director!.picture),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 10),
                                    child: Text(
                                      movie.director!.name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    DescriptionTitle(value: appL10n(context)!.casting),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            movie.cast?.length ?? 0,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        movie.cast![index].picture),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 10),
                                    child: Text(
                                      movie.cast![index].name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
