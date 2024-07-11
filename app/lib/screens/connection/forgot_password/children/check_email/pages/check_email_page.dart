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
import 'package:getout/widgets/fields/email_field.dart';

class CheckEmailPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageController;
  final TextEditingController email;
  final ConnectionService service;


  CheckEmailPage(
      {super.key, required this.pageController, required this.email, required this.service});

  @override
  Widget build(BuildContext context) {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: AutoSizeText(
            ' ${appL10n(context)!.forgot_password.toUpperCase()}'.padRight(
                21, String.fromCharCodes([0x00A0, 0x0020])),
            maxLines: 1, minFontSize: 16.0, maxFontSize: 32.0),
        leading: const BackButton(),
      ),
      body: Column(children: [
        const SizedBox(height: 40),
        Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //              mainAxisAlignment: MainAxisAlignment.center, todo remove scroll or set height.
              children: [
                EmailField(controller: email),
              ]
          )),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (false) //todo https://stackoverflow.com/questions/58243997/manually-setting-flutter-validation-error
          ? const CircularProgressIndicator()
          : SizedBox(
          width: 90 * phoneWidth / 100,
          height: 65,
          child: FloatingActionButton(
            shape: Theme.of(context).floatingActionButtonTheme.shape,
            backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                pageController.jumpToPage(1);
              }
            },
            child: Text(appL10n(context)!.receive_code,
                style: const TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          )),
/*      ForgotPasswordButton(
          formKey: _formKey, onPressed: () {
        if (_formKey.currentState!.validate()) {
          pageController.jumpToPage(1);
        }
      }),*/
    );
  }
}

/*BlocListener<CheckEmailBloc, CheckEmailState>( todo error codes
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          if (state.exception is DioException && (state.exception as DioException).response != null) {
            switch((state.exception as DioException).response!.statusCode) {
              case HttpStatus.INTERNAL_SERVER_ERROR:
                showSnackBar(context, appL10n(context)!.email_validator);
                break;
              case HttpStatus.UNPROCESSABLE_ENTITY:
                showSnackBar(context, appL10n(context)!.email_validator);
                break;
            }
          } else {
            showSnackBar(context, appL10n(context)!.error_unknow);
          }
        }
        if (state.status.isSuccess) {
          pageController.jumpToPage(1);
        }
      },
      child:
}*/

/*class ForgotPasswordButton extends StatelessWidget {

  final GlobalKey<FormState> formKey;
  final Function()? onPressed;

  ForgotPasswordButton({super.key, required this.formKey, this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<CheckEmailBloc, CheckEmailState>(
      builder: (context, state) {
        return (false)
            ? const CircularProgressIndicator()
            : SizedBox(
                width: 90 * phoneWidth / 100,
                height: 65,
                child: FloatingActionButton(
                  shape: Theme.of(context).floatingActionButtonTheme.shape,
                  backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                  onPressed: onPressed,
                  child: Text(appL10n(context)!.receive_code,
                      style: const TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ));
      },
    );
  }
}*/
