/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getout/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key, required this.title, required this.categories})
      : super(key: key);

  final String title;
  final List<Category> categories;

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  // Obtain shared preferences.
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _boolean;
  final prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _boolean = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('counter') ?? false;
    });
  }

  // Obtain shared preferences.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          preferenceTitle(context, widget.title),
          const SizedBox(height: 40),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return categoryCard(context, widget.categories[index]);
                  })),
        ]));
  }

  Widget preferenceTitle(BuildContext context, String name) {
    return Text(
      name,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget categoryCard(BuildContext context, Category one) {
    bool selected = one.isSwitched ?? false;
    return Column(children: [
      const SizedBox(height: 10),
      SizedBox(
          width: 300,
          height: 50,
          child: OutlinedButton(
              onPressed: () =>
                  setState(() => one.isSwitched = selected ? false : true),
              style: OutlinedButton.styleFrom(
                  side: selected
                      ? const BorderSide(color: Color(0xFF584CF4), width: 3)
                      : const BorderSide(color: Colors.black, width: 0.4)),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                        value: one.isSwitched,
                        onChanged: (value) {
                          setState(() {
                            one.isSwitched = value;
                            //_storeCheckBox('checklist.${widget.title}.$one', value!);
                          });
                        },
                        checkColor: Colors.transparent)),
                const SizedBox(width: 80),
                Text(
                    textAlign: TextAlign.center,
                    one.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ])))
    ]);
  }
}
