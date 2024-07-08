/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
// import 'package:getout/tools/app_l10n.dart';

class DefaultButton extends StatelessWidget {
  final Function() onPressed;
  final String title;

  const DefaultButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 64,
        child: FloatingActionButton(
      child: Text(title,
          style: Theme.of(context).textTheme.labelMedium),
      onPressed: () => onPressed(),
    ));
  }
}
