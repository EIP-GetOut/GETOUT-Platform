/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:getout/tools/tools.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String description;
  final int maxLines;

  const PageTitle({super.key, required this.title, this.description = '', this.maxLines = 1});

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: Tools.widthFactor(context, 0.80),
      child: (description == '') ?
          AutoSizeText(
            title,
            maxLines: maxLines,
            minFontSize: 18.0,
            maxFontSize: 24.0,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
            wrapWords: true,
          )
        : Column(
            children: [
              AutoSizeText(
                title,
                maxLines: maxLines,
                minFontSize: 18.0,
                maxFontSize: 24.0,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
                wrapWords: true,
              ),
              AutoSizeText(
                description,
                maxLines: 4,
                minFontSize: 14.0,
                maxFontSize: 16.0,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
                wrapWords: true,
              ),
            ],
        ),
    );
  }
}