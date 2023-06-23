/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/form/Pages/literary_genre.dart';
import 'package:getout/form/Widgets/check_box_list_widget_interest_areas.dart';
import 'package:getout/form/Widgets/four_point.dart';

class AreasOfInterest extends StatelessWidget {
  const AreasOfInterest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VOS PREFERENCES',
        style: TextStyle(color: Colors.black, fontSize: 30,
          decoration: TextDecoration.underline,
          decorationColor:  Color.fromRGBO(213, 86, 65, 1),),),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(213, 86, 65, 1), shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),),
              child: const Text('Suivant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
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