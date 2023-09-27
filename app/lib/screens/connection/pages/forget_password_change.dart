/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:getout/models/connection/forget_password_change.dart';
import 'package:flutter/material.dart';
import 'package:getout/screens/connection/widgets/fields.dart';
import 'package:getout/screens/connection/pages/login.dart';
import 'package:getout/services/requests/requests_service.dart';

class ForgetPasswordChangePage extends StatefulWidget {
  const ForgetPasswordChangePage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordChangePage> createState() => _ForgetPasswordChangePageState();
}

class _ForgetPasswordChangePageState extends State<ForgetPasswordChangePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String textState = '';

  Future<void> forgetPasswordChangePressed() async
  {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    return RequestsService.instance
        .forgetPasswordChange(ForgetPasswordChangeRequest(
        email: emailController.text, code: codeController.text, password: password2Controller.text))
        .then((ForgetPasswordChangeResponseInfo res) {
      if (res.statusCode == ForgetPasswordChangeResponseInfo.success) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ConnectionPage()));
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
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: const Text(
          'Mot de Passe Oublié',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            decorationThickness: 4,
            decorationColor: Color.fromRGBO(213, 86, 65, 0.992),
            decoration:
            TextDecoration.underline,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// TODO a loop for all fields (padding with each field)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: MailField(controller: emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: CodeField(controller: codeController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: PasswordField(controller: passwordController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SecondPasswordField(controller: password2Controller, fstPassword: passwordController.text),
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
            onPressed: forgetPasswordChangePressed,
            child: const Text('Changer de mot de passe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }

}
