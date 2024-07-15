/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>, Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

///screen
import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/screens/home/bloc/home_provider.dart';
import 'package:getout/screens/form/pages/form.dart';
import 'package:getout/screens/connection/login/pages/login.dart';

///bloc
import 'package:getout/bloc/observer.dart';
import 'package:getout/bloc/locale/bloc.dart';
import 'package:getout/bloc/theme/bloc.dart';
import 'package:getout/bloc/user/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  Bloc.observer = const AppBlocObserver(); // BLoC MiddleWare.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Directory appDocDir = await getApplicationDocumentsDirectory();
  runApp(MainProvider(appDocDir.path));
}

class MainProvider extends StatelessWidget {
  final String dirPath;

  const MainProvider(this.dirPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
          providers: [
            //Data
            BlocProvider(create: (_) => LocaleBloc(context)),
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider(create: (_) => UserBloc()..add(SetupEvent(dirPath: dirPath))),
          ],
          child: const MainPage(),
        );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final locale = context.watch<LocaleBloc>().state;
      final themeData = context.watch<ThemeBloc>().state;

      return MaterialApp(
          title: 'Get Out',
          supportedLocales: const [Locale('fr'), /*Locale('en')*/],
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          //supportedLocales: AppLocalizations.supportedLocales,
          theme: themeData,
          home: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.Logout:
                  return LoginPage(service: ConnectionService(state.cookiePath));
                case Status.Login:
                  return const Forms();
                case Status.LoginWithPrefs:
                  return const HomeProvider();//SizedBox(child: Text('homeProvider, ${state.account}'));
              }
              /*if (state.isServerDown) {
                return ColoredBox(
                    color: Colors.white,
                    child: ObjectLoadingErrorWidget(object: appL10n(context)!.your_account));
              } else {
                return ColoredBox(
                    color: Colors.red,
                    child: ObjectLoadingErrorWidget(object: appL10n(context)!.your_account));
              }*/
            },
          ),
      );
    });
  }
}
