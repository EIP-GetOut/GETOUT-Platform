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
import 'package:getout/widgets/fields/widgets/title_field.dart';
import 'package:getout/screens/settings/widget/edit_password_fields.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  fieldTitle('Mot de passe actuel'.toUpperCase(), true),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: OldPasswordField()),
                  const SizedBox(height: 15),
                  fieldTitle('Nouveau mot de passe'.toUpperCase(), true),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: NewPasswordField()),
                  const SizedBox(height: 15),
                  fieldTitle(appL10n(context)!.confirm_password.toUpperCase(), true),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: ConfirmPasswordField()),
                  const SizedBox(height: 15),
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


/*
import 'package:flutter/material.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/settings/services/service.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/validator/field.dart';
import 'package:getout/tools/validator/password.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/button/floating_button.dart';

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingService service = SettingService();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String password = '';
    String newPassword = '';
    String confirmPassword = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('MOT DE PASSE'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 16.0, bottom: 64.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.center, todo remove scroll or set height.
              children: [
                PasswordField(
                    onChanged: (value) => password = value,
                    validator: (value) => mandatoryValidator(context, password)),
                NewPasswordField(
                    onChanged: (value) => newPassword = value,
                    validator: (value) => newPasswordValidator(context, newPassword)),
                ConfirmPasswordField(
                    onChanged: (value) => confirmPassword = value,
                    validator: (value) => confirmPasswordValidator(context, newPassword, confirmPassword)),
                const SizedBox(height: 32),
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
          title: appL10n(context)!.edit_password,
          onPressed: () async {
            //todo setup request & error handling
            if (formKey.currentState!.validate()) {
              try {
                StatusResponse response =
                    await service.changePassword(password, newPassword);
                if (response.status == HttpStatus.OK) {}
                //handle response
              } catch (e) {
                //handle error
              }
            }
          }),
    );
  }
}
*/
