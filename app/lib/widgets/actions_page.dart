/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';


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
                      ? 'Ajouter aux vues'
                      : 'Retirer des vues',
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
                  print("icon pressed");
                  showCustomSnackBar(context: context, color: Colors.green, message: 'Le film a bien été ajouté à la watchlist', icon: Icons.check_circle_rounded);
                },
              ),
              Text(
                  movie.liked != null && movie.liked!
                      ? "J'aime"
                      : "Je n'aime pas",
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
                      ? 'Ajouter à la watchlist'
                      : 'Retirer de la watchlist',
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
                      ? 'Pas intéréssé'
                      : 'Intéréssé',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500))
            ]),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Center(
                  child: Text(
                'Fermer',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              )),
            )
          ],
        ),
      ),
    ));
  }
}
