/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/playgrounds/preference/checklist.dart';
import 'package:getout/models/category.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({
    Key? key,
  }) : super(key: key);

  double time_lost = 0;

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

  double usage_date = 0;

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
    PageController controller = PageController(viewportFraction: 1);
//    controller.position = ScrollPosition(physics: ScrollPhysics());
    //controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
    //controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
//    controller.jumpToPage(controller.initialPage);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        //automaticallyImplyLeading: false,
        title: const Text('Vos Préférences',
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
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              padEnds: false,
              children: <Widget>[
                Center(
                    child: SizedBox(
                        height: 100,
                        child: Slider(
                            min: 0.0,
                            max: 10.0,
                            value: widget.time_lost,
                            onChanged: (value) {
                              setState(() {
                                widget.time_lost = value;
                              });
                            }))),
                Center(
                  child: ChecklistPage(title: "Réseaux Sociaux utilisés:", categories: widget.social),
                ),
                Center(
                  child: ChecklistPage(title: "Format de contenues préférés:", categories: widget.content),
                ),
                Center(
                    child: SizedBox(
                        height: 100,
                        child: Slider(
                            min: 0.0,
                            max: 24.0,
                            value: widget.usage_date,
                            onChanged: (value) {
                              setState(() {
                                widget.usage_date = value;
                              });
                            }))),
                Center(
                  child: ChecklistPage(title: "Centre d'interet:", categories: widget.interest),
                ),
                Center(
                  child: ChecklistPage(title: "Genres litéraires:", categories: widget.book),
                ),
                Center(
                  child: ChecklistPage(title: "Genre cinématographique", categories: widget.movie),
                ),
              ],
            )),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: nextButton(context, controller)
    );
    //throw UnimplementedError();
  }

  Widget nextButton(BuildContext context, PageController controller) {
    return SizedBox(
        width: 85 * MediaQuery.of(context).size.width / 100,
        height: 65,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color(0xFF584CF4),
            onPressed: () => controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear),
            child: const Text('Suivant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ))));
  }
}
