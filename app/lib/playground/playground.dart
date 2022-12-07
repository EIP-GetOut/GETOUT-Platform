/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import "package:flutter/material.dart";
import "package:getout/playground/preferences.dart";
import "package:getout/models/category.dart";

class PlaygroundPage extends StatefulWidget {
  PlaygroundPage({Key? key}) : super(key: key);
  final List<Category> categories = [
    Category(title: 'Horreur'),
    Category(title: 'Comedie'),
    Category(title: 'Policier'),
    Category(title: 'Science-Fiction'),
  ];
  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  @override
  Widget build(BuildContext context) {
    return PreferencesPage(title: 'Film', categories: widget.categories);
  }
}
