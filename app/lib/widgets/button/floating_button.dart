/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const FloatingButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 64,
        child: FloatingActionButton(
          onPressed: onPressed,
          child: Text(title,
              style: Theme.of(context).textTheme.labelMedium),
        ));
  }
}