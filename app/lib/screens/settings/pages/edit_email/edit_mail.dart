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
import 'package:getout/tools/validator/email.dart';
import 'package:getout/tools/validator/field.dart';
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/button/floating_button.dart';

class EditMailPage extends StatelessWidget {
  const EditMailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingService service = SettingService();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String password = '';
    String newEmail = '';
    String confirmEmail = '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('ADRESSE EMAIL'),
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
                    onChanged: (String value) => password = value,
                    validator: (_) => mandatoryValidator(context, password)),
                NewEmailField(
                    onChanged: (String value) => newEmail = value,
                    validator: (_) => emailValidator(context, newEmail)),
                ConfirmEmailField(
                    onChanged: (value) => confirmEmail = value,
                    validator: (_) => confirmEmailValidator(context, newEmail, confirmEmail)),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingButton(
          title: appL10n(context)!.edit_email,
          onPressed: () async {
            //todo setup request & error handling, setup validator with tools function;
            if (formKey.currentState!.validate()) {
              try {
                StatusResponse response =
                    await service.changeEmail(password, newEmail);
                if (response.status == HttpStatus.OK) {

                }
                //handle response
              } catch (e) {
                //handle error
              }
            }
          },
        ));
  }
}
