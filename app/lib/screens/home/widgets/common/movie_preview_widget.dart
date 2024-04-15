/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/constants/extern_url.dart';

class MoviePreviewWidget extends StatelessWidget {
  const MoviePreviewWidget({
    super.key,
    required this.posterPath,
    required this.title,
  });

  final String? posterPath;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 100,
      height: 100,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.network(
            '${ExternalConstants.BookImagePreviewPath}$posterPath',
            fit: BoxFit.cover,
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 10),
        child : Container(
        alignment: Alignment.topLeft,
          child: Text(title,
              style: Theme.of(context).textTheme.titleSmall),
        )),
        const SizedBox(height: 5),
        /*Flexible(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(right: 13.0),
            child: Text(overview ?? appL10n(context)!.no_description,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 10)),
          ),
        ),*/
      ]),
    );
  }
}
