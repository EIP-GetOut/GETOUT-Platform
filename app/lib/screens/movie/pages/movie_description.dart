/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';

class MovieDescriptionPage extends StatefulWidget {
  final InfoMovieResponse movie;

  const MovieDescriptionPage({super.key, required this.movie});

  @override
  State<MovieDescriptionPage> createState() => _MovieDescriptionPageState();
}

class _MovieDescriptionPageState extends State<MovieDescriptionPage> {
  _MovieDescriptionPageState();

  Widget separateLine() => const Divider(
        height: 15,
        color: Color.fromARGB(255, 192, 192, 192),
        thickness: 10,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DESCRIPTION'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10), //apply padding to all four sides
                    child: Text('RÉSUMÉ',
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ))),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10), //apply padding to all four sides
                    child: Text(
                        // textAlign: TextAlign.start,
                        widget.movie.overview ??
                            'Aucune description disponible',
                        style: Theme.of(context).textTheme.bodySmall)),
                separateLine(),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10), //apply padding to all four sides
                    child: Text(
                        // textAlign: TextAlign.start,
                        'RÉALISATEUR',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Image.network(
                          widget.movie.director!.picture,
                          height: 120,
                          width: 120,
                        ),
                        Text(
                          widget.movie.director!.name,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                separateLine(),
                const Padding(
                  padding: EdgeInsets.only(
                      left: 10), //apply padding to all four sides
                  child: Text(
                    // textAlign: TextAlign.start,
                    'CASTING',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      widget.movie.cast?.length ?? 0,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Image.network(
                              widget.movie.cast![index].picture,
                              height: 120,
                              width: 120,
                            ),
                            Text(
                              widget.movie.cast![index].name,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
