/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/form/pages/literary_genre.dart';
import 'package:getout/form/widgets/check_box_list_widget_interest_areas.dart';
import 'package:getout/form/widgets/four_point.dart';

class AreasOfInterest extends StatelessWidget {
  const AreasOfInterest({super.key});

  @override
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
            const PageIndicator(currentPage: 1, pageCount: 5),
            const SizedBox(height: 20),
            const Center(child: 
             Text('CENTRE D INTERET :', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 20),
            const CheckboxListWidgetInterestAreas(),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 0.9,
              child : ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Text('Suivant', style: Theme.of(context).textTheme.bodyLarge),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LiteraryGenre()),
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