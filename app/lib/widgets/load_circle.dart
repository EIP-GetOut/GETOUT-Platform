/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

class LoadCirclePage extends StatelessWidget {
  const LoadCirclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CircularProgressIndicator(
          backgroundColor: Color.fromARGB(0, 255, 5, 5),
        ),
      ],
    );
  }
}
