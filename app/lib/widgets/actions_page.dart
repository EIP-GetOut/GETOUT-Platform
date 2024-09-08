/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';

class ActionsPage extends StatelessWidget {
  const ActionsPage({super.key, required this.movie, required this.context});
  final InfoMovieResponse movie;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.transparent,
    body:Padding(
      padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              IconButton(
                icon: const Icon(Icons.remove_red_eye,
                    size: 30), // Icons.visibility_off
                onPressed: () async {},
              ),
              Text(
                  movie.seen != null && movie.seen!
                      ? appL10n(context)!.add_seen
                      : appL10n(context)!.remove_seen,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500))
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  size: 30,
                ), // Icons.favorite_outlined
                onPressed: () async {
                  showCustomSnackBar(context: context, color: Colors.green, message: 'Le film a bien été ajouté à la watchlist', icon: Icons.check_circle_rounded);
                },
              ),
              Text(
                  movie.liked != null && movie.liked!
                      ? appL10n(context)!.like
                      : appL10n(context)!.dislike,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500))
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              IconButton(
                icon: const Icon(Icons.add_circle_outlined,
                    size: 30), // Icons.remove_circle
                onPressed: () async {},
              ),
              Text(
                  movie.wishlisted != null && movie.wishlisted!
                      ? appL10n(context)!.add_watchlist
                      : appL10n(context)!.remove_watchlist,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500))
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              IconButton(
                icon: const Icon(
                  Icons.block_outlined,
                  size: 30,
                ), // Icons.check_circle_rounded
                onPressed: () async {},
              ),
              Text(
                  movie.disliked != null && movie.disliked!
                      ? appL10n(context)!.interested
                      : appL10n(context)!.not_interested,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500))
            ]),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                  child: Text(
                appL10n(context)!.closed,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              )),
            )
          ],
        ),
      ),
    ));
  }
}
