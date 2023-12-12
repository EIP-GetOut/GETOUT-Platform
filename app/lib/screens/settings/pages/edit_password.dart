/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/models/settings/edit_password.dart';
import 'package:getout/screens/connection/widgets/fields.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/global.dart';

class ParametersEditPasswordPage extends StatefulWidget {
  const ParametersEditPasswordPage({super.key});

  @override
  State<ParametersEditPasswordPage> createState() => _ParametersEditPasswordPageState();
}

class _ParametersEditPasswordPageState extends State<ParametersEditPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPassword2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String textState = '';

  final HttpStatus httpStatus = HttpStatus({
    HttpStatus.INTERNAL_SERVER_ERROR: 'Une erreur s\'est produite, veuillez réesayer plus tard',
    HttpStatus.CONFLICT: 'Une erreur c\'est produite',
    HttpStatus.NO_INTERNET: 'Pas de connexion internet',
  });

  Future<void> parametersEditPasswordPressed() async
  {
    if (!_formKey.currentState!.validate() || globalEmail == null) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    return RequestsService.instance
        .settingsEditPassword(SettingsEditPasswordRequest(
        email: globalEmail ?? '', password: passwordController.text, newPassword: newPassword2Controller.text))
        .then((SettingsEditPasswordResponseInfo res) {
      if (res.statusCode == SettingsEditPasswordResponseInfo.success) {
        Navigator.pop(context);
      }
      setState(() {
        isLoading = false;
      });
      if (res.statusCode == 200) {
        textState = 'Mot de passe changé';
      } else if (res.statusCode == 403) {
        textState = 'l\'adresse mail est incorrect';
      } else if (res.statusCode == 502) {
        textState = 'Pas de connexion internet';
      } else if (res.statusCode == 500) {
        textState = 'Une erreur s\'est produite, veuillez reesayer plus tard';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(textState),
          backgroundColor: (res.statusCode != 200
              ? const Color.fromARGB(255, 239, 46, 46)
              : const Color.fromARGB(255, 109, 154, 3))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('MOT DE PASSE'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: PasswordField(controller: passwordController),
                  ),
                  const Text('Votre nouveau mot de passe'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: PasswordField(controller: newPasswordController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SecondPasswordField(controller: newPassword2Controller,
                        fstPassword: newPasswordController.text),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  startButton(context, MediaQuery.of(context).size.width),
                ]),
          )),
    );
  }

  Widget startButton(BuildContext context, double phoneWidth) {
    return SizedBox(
        width: 85 * phoneWidth / 100,
        height: 65,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color.fromRGBO(213, 86, 65, 0.992),
            onPressed: parametersEditPasswordPressed,
            child: const Text('Changer de mot de passe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }

}
