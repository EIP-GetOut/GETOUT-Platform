/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_page_bloc.dart';
import 'package:getout/screens/connection/forgot_password/pages/forgot_password_page.dart';
import 'package:getout/screens/connection/services/service.dart';

import 'package:getout/bloc/user/user_bloc.dart';

class ForgotPasswordProvider extends StatelessWidget {
  const ForgotPasswordProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => ConnectionService(context.watch<UserBloc>().state.cookiePath!),
        child: BlocProvider<ForgotPasswordPageBloc>(
          create: (context) => ForgotPasswordPageBloc(),
          child: const SizedBox(width: 1, height: 1)//ForgotPasswordPage(service: service),
        ),
      ),
    );
  }
}
