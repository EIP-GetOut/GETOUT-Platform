/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>, Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/bloc/locale_bloc.dart';
import 'package:getout/bloc/observer.dart';
import 'package:getout/bloc/locale_bloc.dart';
import 'package:getout/layouts/connection/login.dart';
import 'package:getout/models/category.dart';
import 'package:getout/layouts/home/loading_session.dart';
import 'package:getout/theme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

void main() {
  Bloc.observer = const AppBlocObserver(); // BLoC MidleWare.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleBloc()),
      ],
      child: MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  final List<Category> categories = [
    Category(title: 'Horreur'),
    Category(title: 'Comedie'),
    Category(title: 'Policier'),
    Category(title: 'Science-Fiction'),
  ];

  MyAppView({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final locale = context.watch<LocaleBloc>().state;

      return MaterialApp(
          title: 'Get Out',
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: getOutTheme,
          // home: const WelcomePage(),
//          home: const LoadingPageSession());
          home: const ConnectionPage());
      // return a Widget which depends on the state of BlocA, BlocB, and BlocC
    });
  }
}