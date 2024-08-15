/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan.cariou1@epitech.eu>
*/

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {

  final int current;
  final int total;

  const ProgressBar({super.key, required this.total, required this.current});

  @override
  Widget build(BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index)
      {
        return Column(
          children: [
            const SizedBox(width: 55),
            Container(
              width: 50.0,
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                shape: BoxShape.rectangle,
                color: (index + 1 <= current) ?
                      Theme.of(context).primaryColor
                    : const Color.fromRGBO(212, 212, 212, 1),

              ),
            ),
          ],
        );
      }),
    );
  }
}
