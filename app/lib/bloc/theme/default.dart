/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

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

extension BackgroundColor on ThemeData {
  Color get backgroundColor => const Color.fromARGB(255, 255, 255, 255);
}

extension SecondaryColor on ThemeData {
  Color get secondaryColor => const Color(0xFF078B8B);
}

extension ErrorColor on ThemeData {
  Color get errorColor => const Color.fromARGB(255, 173, 52, 62);
}



final getOutTheme = ThemeData(
  primaryColor: const Color.fromRGBO(213, 86, 65, 1),
  fontFamily: 'Poppins',
  primarySwatch: MaterialColor(0xffD55641, colorMap),
  colorScheme: const ColorScheme.light(
      primary: Color(0xFFD55641),
      error: Color(0xFFAD343E)),
  textTheme:  const TextTheme(
    /// Button
      labelMedium: TextStyle(
          fontSize: 22,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
          color: Colors.white),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
      /// Title of each page
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
      /// Description below the title of each page
      headlineSmall: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      /// text of each checkbox of the preferences
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
      /// title of book/movie in the home page
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontFamily: 'Urbanist',
        decorationColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      /// description of book/movie in the description page
      bodySmall: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 0.8),
        fontSize: 16,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
      ),
      /// text for the "type" (book/movie) and duration
      labelSmall: TextStyle(
          fontSize: 22,
          fontFamily: 'Urbanist',
          color: Colors.black,
          fontWeight: FontWeight.w600),
      /// SnackBar
      displaySmall: TextStyle(
        fontFamily: 'Urbanist',
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
      ),
      /// Welcome text of the home page
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.bold,
      ),
      /// text below the welcome text of the home page
      displayMedium: TextStyle(
        fontFamily: 'Urbanist',
        color: Colors.black,
        fontSize: 18,
      )
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    centerTitle: true,
    titleSpacing: 0,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontFamily: 'Poppins',
      decorationThickness: 8,
      decorationColor: Color.fromRGBO(213, 86, 65, 0.5),
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 60)),
      backgroundColor: WidgetStateProperty.all<Color>(
        const Color.fromRGBO(213, 86, 65, 1),
      ),
      foregroundColor: WidgetStateProperty.all<Color>(
        const Color.fromARGB(255, 255, 255, 255),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color.fromRGBO(213, 86, 65, 1),
    foregroundColor: Colors.white,
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100.0),
    ),
  ),
);
