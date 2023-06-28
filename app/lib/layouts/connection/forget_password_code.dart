/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/layouts/connection/forget_password_change.dart';
import 'package:getout/models/requests/forget_password_code.dart';
import 'package:getout/models/sign/fields.dart';
import 'package:getout/services/requests/requests_service.dart';

class ForgetPasswordCodePage extends StatefulWidget {
  const ForgetPasswordCodePage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordCodePage> createState() => _ForgetPasswordCodePageState();
}

class _ForgetPasswordCodePageState extends State<ForgetPasswordCodePage> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String textState = '';

  Future<void> forgetPasswordCodePressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    return RequestsService.instance
        .forgetPasswordCode(ForgetPasswordCodeRequest(
        email: emailController.text))
        .then((ForgetPasswordCodeResponseInfo res) {
      if (res.statusCode == ForgetPasswordCodeResponseInfo.success) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ForgetPasswordChangePage()));
      }
      setState(() {
        isLoading = false;
      });
      if (res.statusCode == 200) {
        textState = 'Code Envoyé';
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
          'VOTRE PROFIL',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            decorationThickness: 4,
            decorationColor: Color.fromRGBO(213, 86, 65, 0.992),
            decoration: TextDecoration.underline,
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
            onPressed: forgetPasswordCodePressed,
            child: const Text('Recevoir un code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }
}
