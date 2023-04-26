/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/models/category.dart';
// import 'package:getout/layouts/welcome.dart';
import 'package:getout/layouts/connection/username_connection.dart';

Map<int, Color> colorMap = {
  50: const Color.fromRGBO(88, 76, 244, .1),
  100: const Color.fromRGBO(88, 76, 244, .2),
  200: const Color.fromRGBO(88, 76, 244, .3),
  300: const Color.fromRGBO(88, 76, 244, .4),
  400: const Color.fromRGBO(88, 76, 244, .5),
  500: const Color.fromRGBO(88, 76, 244, .6),
  600: const Color.fromRGBO(88, 76, 244, .7),
  700: const Color.fromRGBO(88, 76, 244, .8),
  800: const Color.fromRGBO(88, 76, 244, .9),
  900: const Color.fromRGBO(88, 76, 244, 1),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Category> categories = [
    Category(title: 'Horreur'),
    Category(title: 'Comedie'),
    Category(title: 'Policier'),
    Category(title: 'Science-Fiction'),
  ];

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Get Out',
        theme: ThemeData(
            primarySwatch: MaterialColor(0xff584CF4, colorMap),
            fontFamily: 'Poppins'),
        // home: const WelcomePage(),
        home: const ConnectionPage());
  }
}
