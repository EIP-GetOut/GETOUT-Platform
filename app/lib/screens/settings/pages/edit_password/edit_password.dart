/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/edit_password/edit_password_bloc.dart';
import 'package:getout/screens/settings/services/edit_password.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/tools/tools.dart';

class EditPasswordPage extends StatelessWidget {

  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocProvider<EditPasswordBloc>(
        create: (context) => EditPasswordBloc(),
        child: Builder(builder: (context)
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text('MOT DE PASSE'),
              leading: const BackButton(),
            ),
            body: Form(
              key: formKey,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: EditOldPasswordField()
                      ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: EditNewPasswordField()),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: EditConfirmPasswordField()),
                ],
              ),
            ),
            floatingActionButton: SendNewNewButton(formKey: formKey),
          );
        }));
  }
}

class SendNewNewButton extends StatelessWidget {
  const SendNewNewButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
      builder: (context, state) {
        return (state.status == Status.loading)
            ? const CircularProgressIndicator()
            : SizedBox(
            width: Tools.widthFactor(context, 0.90),
            height: 65,
            child: FloatingActionButton(
              child: AutoSizingText('Changer de mot de passe',
                  minSize: 70,
                  maxSize: 300,
                  sizeFactor: 0.65,
                  height: 40,
                  style: Theme.of(context).textTheme.labelMedium),
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                String oldPassword = context.read<EditPasswordBloc>().state.oldPassword;
                String newPassword = context.read<EditPasswordBloc>().state.newPassword;
                EditPasswordServices()
                    .sendNewPassword(EditPasswordRequestModel(oldPassword: oldPassword, newPassword: newPassword))
                    .then((final EditPasswordResponseModel value) {
                  if (value.statusCode == HttpStatus.UNAUTHORIZED) {
                    showSnackBar(context, 'Mot de passe actuel incorrect');
                  } else if (!value.isSuccessful) {
                    showSnackBar(context, 'Une erreur est survenue veuillez réessayer plus tard');
                  } else {
                    showSnackBar(context, 'Votre mot de passe a bien été modifié', color: Colors.green);
                  }
                });
              },
            ));
      },
    );
  }
}
