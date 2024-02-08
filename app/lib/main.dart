/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>, Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dio/dio.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/bloc/locale/bloc.dart';
import 'package:getout/bloc/observer.dart';
import 'package:getout/bloc/theme/bloc.dart';
import 'package:getout/bloc/user/bloc.dart';
import 'package:getout/screens/connection/get_session/bloc/get_session_bloc.dart';
import 'package:getout/screens/connection/get_session/bloc/get_session_service.dart';
import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/screens/connection/bloc/connection_provider.dart';
import 'package:getout/screens/home/bloc/home_provider.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver(); // BLoC MiddleWare.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainProvider());
}

class MainProvider extends StatelessWidget {
  const MainProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => GetSessionService(),
        child: MultiBlocProvider(
          providers: [
        //Data
        BlocProvider(create: (_) => LocaleBloc(context)),
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider<GetSessionBloc>(
              create: (context) => GetSessionBloc(
                service: context.read<GetSessionService>(),
              )
            ),
        BlocProvider(create: (_) => UserBloc()),
      ],
      child: const MainPage(),
    ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context) {
      final locale = context.watch<LocaleBloc>().state;
      final themeData = context.watch<ThemeBloc>().state;
      final user = context.watch<UserBloc>().state;

      user.setIsSigned();

      print("is signed : ");
      print(user.isSigned);

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
          theme: themeData,
          home: RepositoryProvider(
            create: (context) => ConnectionService(dio: Dio()),
            child: (!user.isSigned)
                ? const ConnectionProvider()
                : const HomeProvider(),
          ),
      );
    });
  }
}
