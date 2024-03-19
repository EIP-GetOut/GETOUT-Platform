/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/settings/services/service.dart';

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
                    validator: (value) =>
                        password.isNotEmpty ? null : 'le champs est vide'),
                NewPasswordField(
                    onChanged: (value) => newPassword = value,
                    validator: (value) => newPassword.isNotEmpty
                        ? null
                        : 'le champs ne peut etre vide'),
                ConfirmPasswordField(
                    onChanged: (value) => confirmPassword = value,
                    validator: (value) => confirmPassword.isNotEmpty
                        ? null
                        : 'le champs ne peut etre vide'),
                const SizedBox(height: 32),
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(
          title: 'changer le mot de passe',
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
