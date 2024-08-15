/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

Widget defaultTitle(final String title, bool isMandatory)
{
  return Row(
    children: [
      const SizedBox(width: 10),
      Text(title,
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      if (isMandatory)
        const Text('*',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red)),
    ],
  );
}
