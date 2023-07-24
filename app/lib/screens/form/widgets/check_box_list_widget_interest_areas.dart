/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/global.dart';

class CheckboxListWidgetInterestAreas extends StatefulWidget {
  const CheckboxListWidgetInterestAreas({super.key});

  @override
  State<CheckboxListWidgetInterestAreas> createState() => _CheckboxListWidgetState();
}

class _CheckboxListWidgetState extends State<CheckboxListWidgetInterestAreas> {
  final List<bool> _checkboxValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.all(16.0),
      child : Column(
      children: [
        CheckboxListTile(
          title: Text('Technologie', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge),
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
          activeColor: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: Text('Sport', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge),
          value: _checkboxValues[1],
          onChanged: (value) {
            setState(() {
              _checkboxValues[1] = value!;
              boxInterestValue = _checkboxValues;
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
          activeColor: Theme.of(context).primaryColor
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: Text('Musique', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge),
          value: _checkboxValues[2],
          onChanged: (value) {
            setState(() {
              _checkboxValues[2] = value!;
              boxInterestValue = _checkboxValues;
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
          activeColor: Theme.of(context).primaryColor
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: Text('Voyage', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge),
          value: _checkboxValues[3],
          onChanged: (value) {
            setState(() {
              _checkboxValues[3] = value!;
              boxInterestValue = _checkboxValues;
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
          activeColor: Theme.of(context).primaryColor
        ),
        const SizedBox(height: 5),
        CheckboxListTile(
          title: Text('Activite artistique', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge),
          value: _checkboxValues[4],
          onChanged: (value) {
            setState(() {
              _checkboxValues[4] = value!;
              boxInterestValue = _checkboxValues;
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
          activeColor: Theme.of(context).primaryColor,
        ),
      ],
    ),);
  }
}