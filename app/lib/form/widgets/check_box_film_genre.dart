/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';

class CheckboxListWidgetFilmGenre extends StatefulWidget {
  const CheckboxListWidgetFilmGenre({super.key});

  @override
  State<CheckboxListWidgetFilmGenre> createState() => _CheckboxListWidgetState();
}

class _CheckboxListWidgetState extends State<CheckboxListWidgetFilmGenre> {
  final List<bool> _checkboxValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.all(16.0),
      child : Column(
      children: [
        CheckboxListTile(
          title: const Text('Action', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          value: _checkboxValues[0],
          onChanged: (value) {
            setState(() {
              _checkboxValues[0] = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: const Text('Policier', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          value: _checkboxValues[1],
          onChanged: (value) {
            setState(() {
              _checkboxValues[1] = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: const Text('Western', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          value: _checkboxValues[2],
          onChanged: (value) {
            setState(() {
              _checkboxValues[2] = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: const Text('Horreur', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          value: _checkboxValues[3],
          onChanged: (value) {
            setState(() {
              _checkboxValues[3] = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: const Text('Comedie', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          value: _checkboxValues[4],
          onChanged: (value) {
            setState(() {
              _checkboxValues[4] = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          tileColor: Colors.transparent,
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),
            right: BorderSide(color: Colors.black, width: 2.0),
            top: BorderSide(color: Colors.black, width: 2.0),
          ),
          checkColor: Colors.black,
        ),
      ],
    ),);
  }
}