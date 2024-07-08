/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/settings/services/service.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/tools/app_l10n.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingService service = SettingService();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String lang = ''; //(retrieve bloc)

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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.center, todo remove scroll or set height.
              children: [
                SizedBox(height: 32),
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: DefaultButton(
          title: appL10n(context)!.edit_password,
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              try {
                service.setLanguage(lang);
                // if (response.status == HttpStatus.OK) {

                // }
                //handle response
              }
              catch (e) {
                //handle error
              }
            }
          }),
    );
  }
}
