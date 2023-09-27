/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/form/pages/areas_of_interest.dart';
import 'package:getout/screens/form/widgets/time_spent_social_media.dart';
import 'package:getout/screens/form/widgets/four_point.dart';

//Time Spent on Social Media
class SocialMediaSpentTime extends StatelessWidget {
  const SocialMediaSpentTime({super.key});

  @override
  // double _sliderValue = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('VOS PREFERENCES',
        style: Theme.of(context).textTheme.titleSmall),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20,),
            const PageIndicator(currentPage: 0, pageCount: 5),
            const SizedBox(height: 20),
            const Center(child: 
             Text('TEMPS PASSE SUR LES RESEAUX SOCIAUX PAR JOURS :', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            SliderWidget(
              minValue: 1.0,
              maxValue: 12.0,
              divisions: 11,
              initialValue: 1.0,
              onChanged: (value) {
              }
            ),
            const SizedBox(height: 20),
             FractionallySizedBox(
              widthFactor: 0.9,
              child : ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Text('Suivant', style: Theme.of(context).textTheme.bodyLarge),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AreasOfInterest()),
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