/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';
import 'package:getout/screens/settings/services/edit_email.dart';
import 'package:getout/widgets/fields/widgets/title_field.dart';
import 'package:getout/screens/settings/widget/edit_email_fields.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/tools/tools.dart';

class EditEmailPage extends StatelessWidget {

  const EditEmailPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider<EditEmailBloc>(
      create: (context) => EditEmailBloc(),
      child: Builder(builder: (context)
    {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ADRESSE EMAIL'),
          leading: const BackButton(),
        ),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              fieldTitle(appL10n(context)!.email.toUpperCase(), true),
              const SizedBox(height: 20),
              const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  child: EmailField()),
              const SizedBox(height: 30),
              fieldTitle(appL10n(context)!.confirm_email.toUpperCase(), true),
              const SizedBox(height: 20),
              const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  child: ConfirmEmailField()),
              const SizedBox(height: 30),
              fieldTitle(appL10n(context)!.password.toUpperCase(), true),
              const SizedBox(height: 20),
              const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  child: PasswordField()),
            ],
          ),
        ),
        floatingActionButton: SendNewEmailButton(formKey: formKey),
      );
    }));
  }
}

class SendNewEmailButton extends StatelessWidget {
  const SendNewEmailButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
        return (state.status == Status.loading)
            ? const CircularProgressIndicator()
            : SizedBox(
            width: Tools.widthFactor(context, 0.90),
            height: 65,
            child: FloatingActionButton(
              child: AutoSizingText('Changer d\'adresse email',
                  minSize: 70,
                  maxSize: 300,
                  sizeFactor: 0.65,
                  height: 40,
                  style: Theme.of(context).textTheme.labelMedium),
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                String email = context.read<EditEmailBloc>().state.email;
                String password = context.read<EditEmailBloc>().state.password;
                EditEmailServices()
                .sendNewEmail(EditEmailRequestModel(email: email, password: password))
                .then((final EditEmailResponseModel value) {
                  if (!value.isSuccessful) {
                    showSnackBar(context, 'Une erreur est survenue veuillez réessayer plus tard');
                  }
                });
              },
            ));
      },
    );
  }
}