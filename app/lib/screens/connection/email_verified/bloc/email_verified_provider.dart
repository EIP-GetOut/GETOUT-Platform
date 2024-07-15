/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/email_verified/pages/email_verified_page.dart';
import 'package:getout/screens/connection/email_verified/bloc/email_verified_bloc.dart';
import 'package:getout/screens/connection/services/service.dart';

class EmailVerifiedProvider extends StatelessWidget {
  const EmailVerifiedProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => ConnectionService(),
        child: BlocProvider<EmailVerifiedBloc>(
          create: (context) => EmailVerifiedBloc(service: context.read<ConnectionService>()),
          child: EmailVerifiedPage(),
        ),
      ),
    );
  }
}
