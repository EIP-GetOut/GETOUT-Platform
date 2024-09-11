/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>, Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:getout/widgets/page_title.dart';
import 'package:getout/tools/tools.dart';

class TransitionPage extends StatelessWidget {
  final String title;
  final int maxLines;
  final String description;
  final String image;
  final String buttonText;
  final Function()? nextPage;

  const TransitionPage({super.key,
    required this.title,
    this.maxLines = 1,
    this.description = '',
    this.image = '',
    required this.buttonText,
    this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(height: Tools.heightFactor(context, 0.15)),
          PageTitle(
            title: title,
            maxLines: maxLines,
            description: description,
          ),
          if (image != '') SizedBox(height: Tools.heightFactor(context, 0.12)),
          if (image != '') SvgPicture.asset(image, width: Tools.widthFactor(context, 0.83)),
          if (image != '') SizedBox(height: Tools.heightFactor(context, 0.11)),
          if (image == '') SizedBox(height: Tools.heightFactor(context, 0.604)),
        ],
        ),
      ),
    floatingActionButton: SizedBox(
      width: Tools.widthFactor(context, 0.9),
      height: 65,
      child: FloatingActionButton(
        onPressed: () {
          if (nextPage != null) {
            nextPage!();
          } else {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        child: Text(buttonText,
            style: Theme.of(context).textTheme.labelMedium),
      ),
    )
      ,);
  }
}