/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/models/category.dart';
import 'package:getout/pages/home.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage(
      {Key? key, required this.title, required this.categories})
      : super(key: key);

  final String title;
  final List<Category> categories;
  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'VOS PRÉFÉRENCES',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(children: [
          const SizedBox(height: 110,
          child: Center(child: Text("-  -  -  -",
              style: TextStyle(
                  color: Color(0xFF584CF4),
                  fontSize: 50,
                  fontWeight: FontWeight.bold
              )))),
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
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget nextButton(BuildContext context) {
    return SizedBox(
        width: 320,
        height: 70,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color(0xFF584CF4),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
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
          height: 50,
          width: 330,
          child: Card(
              margin: const EdgeInsets.symmetric(),
              shape: selected
                  ? RoundedRectangleBorder(
                      side:
                          const BorderSide(color: Color(0xFF584CF4), width: 3.0),
                      borderRadius: BorderRadius.circular(0),
                    )
                  : RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black, width: 0.3),
                      borderRadius: BorderRadius.circular(0),
                    ),
              child: CheckboxListTile(
                          title: Center(
                              child: Text(
                            one.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          value: one.isSwitched,
                          onChanged: (bool? value) {
                            setState(() {
                              one.isSwitched = value!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: const Color(0xff584CF4),
                          checkColor: Colors.transparent,
                        )
                      ))
    ]);
  }
}
