/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

class PosterAndDescriptionWidget extends StatelessWidget {
  const PosterAndDescriptionWidget({
    super.key,
    required this.posterPath,
    required this.title,
    required this.overview,
  });

  final String? posterPath;
  final String? overview;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 100,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.network(
            '$posterPath',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(title,
              maxLines: 3,
              style: Theme.of(context).textTheme.titleSmall),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(right: 13.0),
            child: Text(overview ?? 'Aucune description disponible',
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.headlineSmall),
          ),
        ),
      ]),
    );
  }
}
