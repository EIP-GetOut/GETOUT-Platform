/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
*/

import 'package:flutter/material.dart';

class PosterAndDescriptionWidget extends StatelessWidget {
  const PosterAndDescriptionWidget({
    Key? key,
    required this.posterpath,
    required this.title,
    required this.overview,
  }) : super(key: key);

  final String? posterpath;
  final String? overview;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 100,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://image.tmdb.org/t/p/w600_and_h900_bestv2$posterpath',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(right: 13.0),
            child: Text(overview ?? 'Aucune description disponible',
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ),
      ]),
    );
  }
}
