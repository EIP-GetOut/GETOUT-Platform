/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getout/playgrounds/preference/checklist.dart';
import 'package:getout/models/category.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({
    Key? key,
  }) : super(key: key);
  final List<Category> social = [
    Category(title: 'Facebook'),
    Category(title: 'Snapchat'),
    Category(title: 'Instagram'),
    Category(title: 'Twitter'),
  ];

  final List<Category> content = [
    Category(title: 'Text'),
    Category(title: 'Image'),
    Category(title: 'Short (<30sec) '),
    Category(title: 'Vidéo (>3min)'),
  ];

  final List<Category> interest = [
    Category(title: 'Technologie'),
    Category(title: 'Sport'),
    Category(title: 'Musique'),
    Category(title: 'Voyage'),
    Category(title: 'Art'),
  ];

  final List<Category> book = [
    Category(title: 'Philosophie'),
    Category(title: 'Polar'),
    Category(title: 'Horreur'),
    Category(title: 'Thriller'),
    Category(title: 'Comédie'),
  ];

  final List<Category> movie = [
    Category(title: 'Action'),
    Category(title: 'Policier'),
    Category(title: 'Western'),
    Category(title: 'Horreur'),
    Category(title: 'Comédie'),
  ];
//  final String title;
//  final List<Category> categories;
  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    double _value = 20;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Préférences',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
            child: PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Center(
              child: Text("Lost Time"),
            ),
            Center(
              child: ChecklistPage(title: "Réseaux Sociaux utilisés:", categories: widget.social),
            ),
            Center(
              child: ChecklistPage(title: "Format de contenues préférés:", categories: widget.content),
            ),
            Center(
              child: Container(
                width: double.maxFinite,
                child: CupertinoSlider(
                  min: 0.0,
                  max: 100.0,
                  value: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ),
            Center(
              child: ChecklistPage(title: "Centre d'interet:", categories: widget.interest),
            ),
            Center(
              child: ChecklistPage(title: "Genres litéraires:", categories: widget.book),
            ),
            Center(
              child: ChecklistPage(title: "title", categories: widget.movie),
            ),
          ],
        ))
      ]),
    );
    //throw UnimplementedError();
  }
}
