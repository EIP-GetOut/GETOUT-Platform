import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension BackgroundColor on ThemeData {
  Color get backgroundColor => const Color.fromARGB(255, 255, 223, 176);
}

extension SecondaryColor on ThemeData {
  Color get secondaryColor => const Color(0xFF078B8B);
}

extension ErorColor on ThemeData {
  Color get erorColor => const Color.fromARGB(255, 173, 52, 62);
}

final getOutTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 145, 77, 125),
  textTheme: GoogleFonts.robotoTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 145, 77, 125)),
      foregroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 49, 54, 65)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 49, 54, 65),
    foregroundColor: Color.fromARGB(255, 145, 77, 125),
  ),
);
