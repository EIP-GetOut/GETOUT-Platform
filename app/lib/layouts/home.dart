/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import "package:flutter/material.dart";
import "package:getout/playgrounds/main_playground.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double phoneHeight = MediaQuery.of(context).size.height;
    final double phoneWidth = MediaQuery.of(context).size.width;
    bool isLandscape = (phoneWidth > phoneHeight);
    return Scaffold(
      body: Column(children: [
        Row(children: [
                SizedBox(width: (isLandscape ? 20 : 10) * phoneWidth / 100),
                SizedBox(
                  height: (isLandscape ? 20 : 27) * phoneHeight / 100,
                  width: (isLandscape ? 20 : 27) * phoneWidth / 100,
                  child: Image.asset("assets/GetOut_logo.png")),
                SizedBox(width: (isLandscape ? 4 : 8) * phoneWidth / 100),
                const Text("GETOUT",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ))
        ]),
        SizedBox(
          height: (isLandscape ? 49 : 30) * phoneHeight / 100,
          width: (isLandscape ? 47 : 80) * phoneWidth / 100,
          child: Align(
          alignment: Alignment.topCenter,
            child: Image.asset("assets/jesaispas.png")),
        ),
        SizedBox(
            height: 13 * phoneHeight / 100,
            width: 95 * phoneWidth / 100,
            child: const Text("Devenez plus productif en réduisant le temps passé sur les réseaux sociaux",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
            )))
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
              width: 85 * phoneWidth / 100,
              height: 65,
              child: FloatingActionButton(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  backgroundColor: const Color(0xFF584CF4),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPlaygroundPage())),
                  child: const Text('Commencer l\'aventure',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                    ))
            )
        )
    );
  }
}
