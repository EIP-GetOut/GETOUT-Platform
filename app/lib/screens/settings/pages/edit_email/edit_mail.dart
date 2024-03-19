/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/settings/services/service.dart';

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
                    validator: (value) =>
                        password.isNotEmpty ? null : 'le champs est vide'),
                NewEmailField(
                    onChanged: (String value) => newEmail = value,
                    validator: (value) =>
                        (newEmail.isNotEmpty) ? null : 'l\'email est invalide'),
                ConfirmEmailField(
                    onChanged: (value) => confirmEmail = value,
                    validator: (value) => (confirmEmail.isNotEmpty)
                        ? null
                        : 'la confirmation est invalide'),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingButton(
          title: 'Changer d\'email',
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

/*
  void _validateEmails() {
    String oldEmail = passwordController.text;
    String newEmail = newEmailController.text;
    String confirmEmail = confirmNewEmailController.text;

    if (_isValidEmail(oldEmail) &&
        _isValidEmail(newEmail) &&
        _isValidEmail(confirmEmail)) {
      if (newEmail != confirmEmail) {
        _showErrorDialog('Les adresses e-mail ne correspondent pas.');
        return;
      }

      // Changements enregistrés avec succès
      _showSuccessDialog('Changements enregistrés avec succès !');
    } else {
      _showErrorDialog('Veuillez entrer des adresses e-mail valides.');
    }
  }

  bool _isValidEmail(String email) {
    // Utiliser une expression régulière pour valider l'adresse e-mail
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Succès'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}*/
