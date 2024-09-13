/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/password_field.dart';

class NewEmailPage extends StatelessWidget {
  const NewEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider<EditEmailBloc>(
        create: (context) => EditEmailBloc(),
        child: Builder(builder: (context) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: const Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditEmailField()),
/*                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditConfirmEmailField()),*/
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditPasswordField()),
                ],
              ),
            ),
          );
        }));
  }
}
