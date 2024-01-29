/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/bloc/home_provider.dart';

class EndForm extends StatelessWidget {
  const EndForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            const SizedBox(height: 140),
            Image.asset('assets/entire_logo.png', scale: 0.85),
            const SizedBox(height: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Image.asset('assets/images/Telephone.png', scale: 1.6),
                  Image.asset('assets/images/Dessin.png', scale: 2.5),
                ],
              ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'VOS RÉPONSES ONT BIEN ÉTÉ ENREGISTRÉES !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          width: 90 * MediaQuery.of(context).size.width / 100,
          height: 65,
          child: FloatingActionButton(
            child: Text('Découvrir l\'application', style: Theme.of(context).textTheme.labelMedium),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeProvider()),
              );
            },
          ),
        )

    );
  }
}
