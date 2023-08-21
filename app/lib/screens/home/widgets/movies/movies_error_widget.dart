/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

class MoviesErrorWidget extends StatelessWidget {
  const MoviesErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content:
    //         Text('Une erreur s\'est produite, veuillez réesayer plus tard'),
    //     backgroundColor: Color.fromARGB(255, 239, 46, 46)));
    return const Center(
        child: Padding(
            padding:
                EdgeInsets.only(bottom: 100), //apply padding to all four sides
            child: Center(
              child: Text(
                'Something was wrong during load movies',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )));
  }
}
