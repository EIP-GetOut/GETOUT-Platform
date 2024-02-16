/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_page_bloc.dart';
import 'package:getout/screens/connection/forgot_password/children/check_email/bloc/check_email_bloc.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/screens/connection/login/pages/login.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/connection/services/service.dart';

class ConnectionProvider extends StatelessWidget {
  const ConnectionProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => ConnectionService(),
        child: MultiBlocProvider(
          providers: [
            /// Service Bloc
            BlocProvider(create: (_) => LoginBloc(
                service: context.read<ConnectionService>())),
            BlocProvider(create: (_) => RegisterBloc(
                service: context.read<ConnectionService>())),
            BlocProvider(create: (context) => CheckEmailBloc(
                  service: context.read<ConnectionService>())),
            BlocProvider(create: (context) => NewPasswordBloc(
                service: context.read<ConnectionService>())),
            /// Page Bloc
            BlocProvider(create: (context) => ForgotPasswordPageBloc()),
          ],
          child: LoginPage(),
        ),
      ),
    );
  }
}
