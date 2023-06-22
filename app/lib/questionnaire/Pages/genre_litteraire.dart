import 'package:flutter/material.dart';
import 'package:getout/questionnaire/Pages/genre_cinematographique.dart';
import 'package:getout/questionnaire/Widgets/check_box_genre_litteraire.dart';
import 'package:getout/questionnaire/Widgets/four_point.dart';

class GenreLitteraire extends StatelessWidget {
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
            PageIndicator(currentPage: 2, pageCount: 5),
            const SizedBox(height: 20),
            const Center(child: 
             Text('GENRE LITTERAIRE :', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 20),
            CheckboxListWidgetGenreLitteraire(),
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
                  MaterialPageRoute(builder: (context) => GenreCinematographique()),
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