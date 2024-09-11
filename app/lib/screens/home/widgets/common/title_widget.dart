/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    required this.asset,
    required this.length,
  });

  final String title;
  final String asset;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        /*Image.asset(
          // popcorn_emoji
          'assets/images/icon/$asset.png',
        ),*/
        const SizedBox(width: 10),
        // Les films que vous allez aimer
        Expanded(
              flex: 2, // adjust the flex factor to control the spacing
              child: Text(title,
                  style: const TextStyle(
                    color: Color(0xFFD55641),
                    fontSize: 22,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Text('$length  ',
            style: const TextStyle(
              color: Color(0xFF565656),
              fontSize: 22,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
            )),
        ]);
  }
}
