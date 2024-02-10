/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/session/session_bloc.dart';
import 'package:getout/screens/connection/session/session_event.dart';
import 'package:getout/screens/connection/session/session_repository.dart';

import 'package:getout/screens/connection/session/session_service.dart';
import 'package:getout/screens/connection/session/session_widget.dart';

class SessionProvider extends StatelessWidget {
  const SessionProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => SessionRepository(service: SessionService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SessionBloc>(
              create: (context) => SessionBloc(
                sessionRepository: context.read<SessionRepository>(),
              )..add(const SessionRequest())
            ),
          ],
          child: const SessionWidget(),
        ),
      ),
    );
  }
}