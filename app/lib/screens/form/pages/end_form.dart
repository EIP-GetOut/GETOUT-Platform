/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/bloc/dashboard/dashboard_provider.dart';

class EndForm extends StatelessWidget {
  const EndForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Image.asset('assets/entire_logo.png', width: 800, height: 200),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Telephone.png',
                      width: 150, height: 180),
                  Image.asset('assets/images/Dessin.png',
                      width: 200, height: 200),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'VOS RÉPONSES ONT BIEN ÉTÉ ENREGISTRÉES',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Text('Découvrir l\'application',
                    style: Theme.of(context).textTheme.bodyLarge),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
