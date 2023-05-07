/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:GetOut/layouts/preference/preference.dart';
import 'package:GetOut/layouts/preference/checklist.dart';

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
          const SizedBox(
            width: 100,
            height: 100,
          ),
          SizedBox(
              width: 300,
              height: 100,
              child: FloatingActionButton(
                  heroTag: 'Checklist',
                  shape: const RoundedRectangleBorder(),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChecklistPage(
                              title: 'Test with empty categories',
                              categories: []))),
                  child: const Text('testing checklist',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )))),
          SizedBox(
            width: 300,
            height: 100,
            child: FloatingActionButton(
                heroTag: 'Preference-page',
                shape: const RoundedRectangleBorder(),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PreferencesPage())),
                child: const Text('Preference page',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ))),
          ),
        ])));
  }
}
