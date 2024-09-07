/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/movie/bloc/movie_bloc.dart';
import 'package:getout/widgets/description_title.dart';
import 'package:getout/tools/app_l10n.dart';

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
        title: Text(appL10n(context)!.description.toUpperCase()),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                DescriptionTitle(value: appL10n(context)!.summary),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                            // textAlign: TextAlign.start,
                            widget.movie.overview ?? appL10n(context)!.no_description,
                            style: Theme.of(context).textTheme.bodySmall))),
                separateLine(),
                DescriptionTitle(value: appL10n(context)!.director),
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
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              widget.movie.director!.name,
                              style: const TextStyle(fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                ),
                separateLine(),
                DescriptionTitle(value: appL10n(context)!.casting),
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
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              widget.movie.director!.name,
                              style: const TextStyle(fontSize: 14),
                            )),
                      ],
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
