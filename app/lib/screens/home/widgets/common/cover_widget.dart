/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

class CoverWidget extends StatelessWidget {
  const CoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
          height: 300,
          width: 300,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.greenAccent),
          )),
    );
  }
}
