/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/settings/services/service.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/validator/field.dart';
import 'package:getout/tools/validator/password.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/button/floating_button.dart';

class EditPasswordPage extends StatelessWidget {
  final SettingService service;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  EditPasswordPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {

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
                    controller: password,
                    validator: (value) => mandatoryValidator(context, password.text)),
                NewPasswordField(controller: newPassword, validator: (value) =>
                    newPasswordValidator(context, newPassword.text)),
                ConfirmPasswordField(controller: confirmPassword,
                    validator: (value) => confirmPasswordValidator(context, newPassword.text, confirmPassword.text)),
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
                    await service.changePassword(password.text, newPassword.text);
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
