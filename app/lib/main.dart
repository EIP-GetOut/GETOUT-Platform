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
import 'package:flutter_localizations/flutter_localizations.dart';

Map<int, Color> colorMap = {
  50: const Color.fromRGBO(213, 86, 65, .1),
  100: const Color.fromRGBO(213, 86, 65, .2),
  200: const Color.fromRGBO(213, 86, 65, .3),
  300: const Color.fromRGBO(213, 86, 65, .4),
  400: const Color.fromRGBO(213, 86, 65, .5),
  500: const Color.fromRGBO(213, 86, 65, .6),
  600: const Color.fromRGBO(213, 86, 65, .7),
  700: const Color.fromRGBO(213, 86, 65, .8),
  800: const Color.fromRGBO(213, 86, 65, .9),
  900: const Color.fromRGBO(213, 86, 65, 1),
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
        localizationsDelegates: const [
         GlobalMaterialLocalizations.delegate
       ],
       supportedLocales: const [
         Locale('en'),
         Locale('fr')
       ],
        theme: ThemeData(
            primarySwatch: MaterialColor(0xffD55641, colorMap),
            fontFamily: 'Poppins',
          colorScheme: const ColorScheme.light(primary: Color(0xFFD55641)),
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        // home: const WelcomePage(),
        home: const ConnectionPage());
  }
}
