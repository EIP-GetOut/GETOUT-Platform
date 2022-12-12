/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/playgrounds/preference/checklist.dart';
import 'package:getout/models/category.dart';
import 'package:getout/playgrounds/preference/slider.dart';
import 'package:getout/layouts/home.dart';

class PreferencesPage extends StatefulWidget {
  PreferencesPage({
    Key? key,
  }) : super(key: key);

  double time_lost = 0;
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
  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(viewportFraction: 1);
    List<Widget> pages = [
      const SliderPage(title: "Temps passé sur les réseaux sociaux par jour:", minTime: 0.0, maxTime: 12.0),
      ChecklistPage(title: "Centre d'interêt:", categories: widget.interest),
      ChecklistPage(title: "Genres littéraires:", categories: widget.book),
      ChecklistPage(title: "Genre cinématographique", categories: widget.movie)
    ];
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Vos préférences',
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
          Expanded(child:
            PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                padEnds: false,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                  return pages[index];
              },
              onPageChanged: (page){
                  setState(() {
                    currentPage = page;
                  });
                }
                )),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: (currentPage == (pages.length - 1)) ? finishButton(context, controller) : nextButton(context, controller)
    );
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
                ))
        )
    );
  }

  Widget finishButton(BuildContext context, PageController controller) {
    return SizedBox(
        width: 85 * MediaQuery.of(context).size.width / 100,
        height: 65,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color(0xFF584CF4),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
            child: const Text('Terminer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ))
        )
    );
  }
}
