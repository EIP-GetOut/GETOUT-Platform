/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                const SizedBox(width: 20),
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const SettingsPage()
                  //           ));
                  // },
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
                        style: Theme.of(context).textTheme.titleMedium),
                    Text('La productivité à portée de main',
                        style: Theme.of(context).textTheme.displayMedium)
                  ],
                ),
                const SizedBox(width: 25),
                Image.asset(
                  'assets/GetOut_logo.png',
                  width: 40,
                ),
              ],
            )
          ],
        ));
  }
}
