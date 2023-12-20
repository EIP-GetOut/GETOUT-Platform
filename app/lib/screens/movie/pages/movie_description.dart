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
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10), //apply padding to all four sides
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/5/5f/Grey.PNG?20071229171831',
                      height: 50,
                      width: 50,
                    )),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10), //apply padding to all four sides
                    child: Text(
                        // textAlign: TextAlign.start,
                        'Réalisateur 1')),
                separateLine(),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 10), //apply padding to all four sides
                    child: Text(
                        // textAlign: TextAlign.start,
                        'CASTING',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                Row(
                  children: List.generate(
                    widget.movie.cast?.length ?? 0,
                    (index) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Image.network(
                            widget.movie.cast![index].isNotEmpty == true
                                ? widget.movie.cast![index][1] // URL de l'image
                                : 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Grey.PNG?20071229171831',
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            widget.movie.cast![index].isNotEmpty == true
                                ? widget.movie.cast![index]
                                    [0] // Nom de l'acteur
                                : 'Non disponible',
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                // Padding(
                //     padding: const EdgeInsets.only(
                //         left: 10), //apply padding to all four sides
                //     child: Image.network(
                //       (movie.cast?.isNotEmpty == true)
                //           ? movie.cast![0][0]
                //           : 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Grey.PNG?20071229171831',
                //       height: 50,
                //       width: 50,
                //     )),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 10), //apply padding to all four sides
                //   child: Text(
                //     (movie.cast?.isNotEmpty == true)
                //         ? movie.cast![0][0]
                //         : 'Non disponibe',
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
