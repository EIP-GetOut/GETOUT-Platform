/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import "package:flutter/material.dart";
import "package:getout/playgrounds/preference/preference.dart";
import 'package:getout/playgrounds/preference/checklist.dart';

class MainPlaygroundPage extends StatefulWidget {
  const MainPlaygroundPage({Key? key}) : super(key: key);

  @override
  State<MainPlaygroundPage> createState() => _MainPlaygroundPageState();
}

class _MainPlaygroundPageState extends State<MainPlaygroundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                height: 100,
              ),
              SizedBox(
                  width: 300,
                  height: 100,
                  child: FloatingActionButton(
                      heroTag: "erwan-préferences",
                      shape: const RoundedRectangleBorder(),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChecklistPage(title: "noobies", categories: []))),
                      child: const Text('Go to preferences',
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        )
                      )
                  )
              ),
              SizedBox(
                  width: 300,
                  height: 100,
                  child: FloatingActionButton(
                      heroTag: "perry-timelost",
                      shape: const RoundedRectangleBorder(),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PreferencesPage())),
                      child: const Text('Go to TimeLost',
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          )
                      )
                  ),
              ),
        ]
    )
    ));
  }
}
