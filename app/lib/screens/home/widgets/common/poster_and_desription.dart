/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/bloc/movies/movies_bloc.dart';

class PosterAndDescriptionWidget extends StatelessWidget {
  const PosterAndDescriptionWidget({
    Key? key,
    required this.movies,
    required this.index,
  }) : super(key: key);

  final List<MoviePreview> movies;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 100,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movies[index].posterPath}',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(movies[index].title,
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
            child: Text(
                movies[index].overview ?? 'Aucune description disponible',
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
