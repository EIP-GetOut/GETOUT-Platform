/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:boxicons/boxicons.dart';

class LikeBooksErrorWidget extends StatelessWidget {
  const LikeBooksErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Icon(Boxicons.bx_error, size: 40, color: Colors.red),
          Text('Impossible de charger les films',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )),
        ]));
  }
}
