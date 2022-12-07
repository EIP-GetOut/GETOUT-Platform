/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/models/category.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({Key? key, required this.title, required this.categories}) : super(key: key);

  final String title;
  final List<Category> categories;
  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('VOS PRÉFÉRENCE',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Column(children : [
        const SizedBox(height: 50),
        Text(widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),),
        const SizedBox(height: 30),
        for (var category in widget.categories)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: CheckboxListTile(
              title: Text(category.title),

              value: category.isSwitched,
              onChanged: (bool? value) {
                setState(() {
                  category.isSwitched = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: const Color(0xff584CF4),
              checkColor: Colors.transparent,

            ),
          )
      ]),
    );
    //throw UnimplementedError();
  }

}
