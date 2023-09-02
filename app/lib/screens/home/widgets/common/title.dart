/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    required this.asset,
  }) : super(key: key);

  final String title;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Image.asset(
          // popcorn_emoji
          'assets/$asset.png',
        ),
        const SizedBox(width: 10),
        // Les films que vous allez aimer
        Text(title,
            style: const TextStyle(
              color: Color(0xFFD55641),
              fontSize: 23,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
