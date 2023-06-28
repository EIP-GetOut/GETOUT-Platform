/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/models/requests/info_movie.dart';

class MovieDescriptionPage extends StatefulWidget {

  final InfoMovieResponse? movie;

  const MovieDescriptionPage({super.key, required this.movie});

  @override
  State<MovieDescriptionPage> createState() => _MovieDescriptionPageState();
}

class _MovieDescriptionPageState extends State<MovieDescriptionPage> {
  Widget separateLine() => const Divider(
        height: 15,
        color: Color.fromARGB(255, 192, 192, 192),
        thickness: 10,
        // )
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          'DESCRIPTION',
          style: Theme.of(context).textTheme.titleSmall),
        leading: const BackButton(),
        backgroundColor: Colors.white10,
        elevation: 0,
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
                        widget.movie?.overview ?? 'Aucune description disponible')),
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
                        'Casting 1')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
