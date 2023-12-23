/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/settings/pages/settings.dart';

class YourBooksHeader extends StatelessWidget {
  const YourBooksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Row(
          children: [
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              child: Image.asset(
                'assets/Profile_picture.png',
                width: 60,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bienvenue !',
                    style: Theme.of(context).textTheme.titleLarge),
                Text('La productivité à portée de main',
                    style: Theme.of(context).textTheme.displayMedium)
              ],
            ),
            const SizedBox(width: 25),
            Image.asset(
              'assets/GetOut_logo.png',
              width: 40,
            ),
            const SizedBox(height: 100),
          ],
        )
      ],
    );
  }
}
