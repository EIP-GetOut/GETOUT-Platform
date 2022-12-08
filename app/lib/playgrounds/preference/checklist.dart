/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/models/category.dart';
import 'package:getout/layouts/home.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key, required this.title, required this.categories}) : super(key: key);

  final String title;
  final List<Category> categories;
  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          const SizedBox(
              height: 110, child: Center(child: Text("-  -  -  -", style: TextStyle(color: Color(0xFF584CF4), fontSize: 50, fontWeight: FontWeight.bold)))),
          preferenceTitle(context, widget.title),
          const SizedBox(height: 60),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return categoryCard(context, widget.categories[index]);
                  })),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: nextButton(context));
  }

  Widget preferenceTitle(BuildContext context, String name) {
    return Text(
      name,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        //decoration: TextDecoration.underline,
      ),
    );
  }

  Widget nextButton(BuildContext context) {
    return SizedBox(
        width: 320,
        height: 70,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color(0xFF584CF4),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
            child: const Text('Suivant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ))));
  }

  Widget categoryCard(BuildContext context, Category one) {
    bool selected = one.isSwitched ?? false;
    return Column(children: [
      const SizedBox(height: 10),
      SizedBox(
          width: 300,
          height: 50,
          child: OutlinedButton(
              onPressed: () => setState(() => one.isSwitched = selected ? false : true),
              style: OutlinedButton.styleFrom(side: selected ?
                          const BorderSide(color: Color(0xFF584CF4), width: 3)
                          : const BorderSide(color: Colors.black, width: 0.4)),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                        value: one.isSwitched,
                        onChanged: (value) {
                          setState(() => one.isSwitched = value);
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
