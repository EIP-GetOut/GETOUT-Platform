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
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/tools/app_l10n.dart';

class EditEmailPage extends StatelessWidget {
  const EditEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider<EditEmailBloc>(
        create: (context) => EditEmailBloc(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  PageTitle(
                      title: appL10n(context)!.change_email,
                      description: appL10n(context)!.change_email_label),
                  const SizedBox(height: 30),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditEmailField()),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditConfirmEmailField()),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: EditPasswordField()),
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
  Widget build(BuildContext context) {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
        return (state.status == Status.loading)
            ? const CircularProgressIndicator()
            : DefaultButton(
                title: appL10n(context)!.edit_email,
                onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    String email = context.read<EditEmailBloc>().state.email;
                    String password =
                        context.read<EditEmailBloc>().state.password;
                    EditEmailServices()
                        .sendNewEmail(EditEmailRequestModel(
                            email: email, password: password))
                        .then((final EditEmailResponseModel value) {
                      if (!value.isSuccessful && context.mounted) {
                        showSnackBar(context,
                            appL10n(context)!.error_unknown);
                      }
                    });
                  },);
      },
    );
  }
}
