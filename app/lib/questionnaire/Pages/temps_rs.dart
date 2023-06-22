import 'package:flutter/material.dart';
import 'package:getout/questionnaire/Pages/centre_interet.dart';
import 'package:getout/questionnaire/Widgets/temps_reseaux_sociaux.dart';
import 'package:getout/questionnaire/Widgets/four_point.dart';


class tempsRs extends StatelessWidget {
  @override
  // double _sliderValue = 0;
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
            const SizedBox(height: 20,),
            PageIndicator(currentPage: 0, pageCount: 5),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(213, 86, 65, 1), shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),),
              child: const Text('Suivant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CenterInteret()),
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