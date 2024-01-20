/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

void showSnackBar(final BuildContext context, final String message) {
  final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(message,
          style: Theme.of(context).textTheme.displaySmall));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
