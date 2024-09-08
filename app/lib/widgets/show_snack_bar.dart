/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(final BuildContext context, final String message, {Color? color})
{
  final snackBar = SnackBar(
      backgroundColor: color ?? Theme.of(context).colorScheme.error,
      content: Text(message,
          style: Theme.of(context).textTheme.displaySmall));
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showCustomSnackBar({
  required BuildContext context,
  required String message,
  required IconData icon,
  required Color color,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3),
}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(icon, color: textColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    elevation: 10,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    duration: duration,
  );

  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}