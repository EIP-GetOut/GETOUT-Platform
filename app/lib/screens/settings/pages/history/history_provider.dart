/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/history/history_bloc.dart';
import 'package:getout/screens/settings/services/service.dart';
import 'history.dart';

class HistoryProvider extends StatelessWidget {
  const HistoryProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => SettingService(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider(lazy: false, create: (context) => HistoryBloc(
                  service: context.read<SettingService>()
              )..add(const HistoryRequest()))
            ],
            child: const HistoryPage()
        )
    );
  }
}
