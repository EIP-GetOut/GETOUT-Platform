/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:getout/screens/connection/services/service.dart';

import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/fields/code_field.dart';
import 'package:getout/widgets/fields/password_field.dart';


class NewPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageController;
  final TextEditingController email;
  final TextEditingController code;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final ConnectionService service;
  static int tries = 0;

  NewPasswordPage(
      {super.key,
      required this.pageController,
      required this.email,
      required this.code,
      required this.password,
      required this.confirmPassword,
      required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            title: AutoSizeText(
                ' ${appL10n(context)!.forgot_password.toUpperCase()}'
                    .padRight(21, String.fromCharCodes([0x00A0, 0x0020])),
                maxLines: 1,
                minFontSize: 16.0,
                maxFontSize: 32.0),
            leading: BackButton(onPressed: () => pageController.jumpToPage(0))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
              const SizedBox(height: 30),
              Form(
              key: _formKey,
                child: Column(children: [
                  CodeField(controller: code,
                      validator: (_) => null, errorString: null),
                  PasswordField(controller: password,
                      validator: (_) => null, errorString: null),
                  ConfirmPasswordField(controller: confirmPassword,
                      validator: (_) => null, errorString: null),
                ]),
              ),
        const SizedBox(height: 30),
        ]))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ForgotPasswordButton(formKey: _formKey)
    );
    /*BlocListener<NewPasswordBloc, NewPasswordState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isError) {
              if (state.exception is DioException &&
                  (state.exception as DioException).response != null &&
                  (state.exception as DioException).response!.statusCode ==
                      HttpStatus.FORBIDDEN) {
                tries += 1;
                if (tries >= 3) {
                  Navigator.pop(context);
                  tries = 0;
                  showSnackBar(context, 'Vous entrez le mauvais code trop de fois, veuillez réesayer plus tard');
                } else {
                  showSnackBar(context, 'Le code est incorrect');
                }
              } else if (state.exception is DioException &&
                  (state.exception as DioException).response != null &&
                  (state.exception as DioException).response!.statusCode ==
                      HttpStatus.BAD_REQUEST) {
                showSnackBar(context,
                    'Le nouveau mot de passe doit être différent de l\'ancien');
              } else {
                showSnackBar(context,
                    'Une erreur s\'est produite, veuillez reesayer plus tard');
              }
            }
            if (state.status.isSuccess) {
              Navigator.pop(context);
              showSnackBar(
                  context, 'Votre mot de passe a été modifié avec succès',
                  color: Colors.green);
            }
          },
          child: // *stuff*
      ); */
  }
}

class ForgotPasswordButton extends StatelessWidget {

  final GlobalKey<FormState> formKey;

  const ForgotPasswordButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return /*BlocBuilder<NewPasswordBloc, NewPasswordState>(
      builder: (context, state) {
        return state.status.isLoading
            ? const CircularProgressIndicator()
            : */SizedBox(
                width: 90 * phoneWidth / 100,
                height: 65,
                child: FloatingActionButton(
                  shape: Theme.of(context).floatingActionButtonTheme.shape,
                  backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                  onPressed: () {
                    /*if (formKey.currentState!.validate()) {
                      context
                          .read<NewPasswordBloc>()
                          .add(ForgotPasswordSubmitted());
                    }*/
                  },
                  child: Text(appL10n(context)!.edit_password,
                      style: const TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ));
/*      },
    );*/
  }
}
