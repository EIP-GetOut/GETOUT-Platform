/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:boxicons/boxicons.dart';

//todo responsive
class ObjectLoadingErrorWidget extends StatelessWidget {
  const ObjectLoadingErrorWidget({super.key, required this.object});

  final String object;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          const Icon(Boxicons.bx_error, size: 40, color: Colors.red),
          Text('Impossible de charger $object.',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              )),
        ])));
  }
}
