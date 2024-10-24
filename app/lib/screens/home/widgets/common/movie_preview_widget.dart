/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/constants/extern_url.dart';

class MoviePreviewWidget extends StatelessWidget {
  const MoviePreviewWidget(
      {super.key,
      required this.posterPath,
      required this.title,
      required this.isLast});

  final String? posterPath;
  final String title;
  final bool isLast;

  @override
Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 20.0, right: isLast ? 20 : 0),
    width: 105,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.network(
            '${ExternalConstants.MovieImagePreviewPath}$posterPath',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 15),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Limite les lignes pour éviter les débordements
          ),
        ),
      ],
    ),
  );
}
}
