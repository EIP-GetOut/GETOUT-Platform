/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>, Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:getout/screens/connection/bloc/connection_provider.dart';
import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/screens/home/bloc/home_provider.dart';
import 'package:getout/screens/form/pages/form.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';
import 'package:getout/bloc/session/session_service.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/locale/bloc.dart';
import 'package:getout/bloc/observer.dart';
import 'package:getout/bloc/theme/bloc.dart';
import 'package:getout/widgets/loading.dart';
import 'package:getout/tools/status.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  Bloc.observer = const AppBlocObserver(); // BLoC MiddleWare.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainProvider());
}

class MainProvider extends StatelessWidget {
  const MainProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => ConnectionService()),
          RepositoryProvider(create: (context) => SessionService()),
        ],
        child: MultiBlocProvider(
          providers: [
            //Data
            BlocProvider(create: (_) => LocaleBloc(context)),
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider<SessionBloc>(
                create: (context) => SessionBloc(
                  sessionService: context.read<SessionService>(),
                )..add(const SessionRequest())
            ),
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

      return MaterialApp(
          title: 'Get Out',
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          //supportedLocales: AppLocalizations.supportedLocales,
          theme: themeData,
          home: BlocBuilder<SessionBloc, SessionState>(
            builder: (context, state) {
              if (state.status.isFound) {
                return const HomeProvider();
              } else if (state.status.isFoundWithoutPreferences) {
                return const Forms();
              } else if (state.status.isLoading) {
                  return const Center(child: LoadingPage());
              } else if (state.status.isError) {
                /// TODO : Add a retry button
                return const ColoredBox(
                        color: Colors.white,
                        child: ObjectLoadingErrorWidget(object: 'la session'));
              } else if (state.status.isNotFound) {
                return const ConnectionProvider();
              } else {
                return const ColoredBox(
                    color: Colors.red,
                    child: ObjectLoadingErrorWidget(object: 'erreur inconnue'));
              }
            },
          ),
      );
    });
  }
}
