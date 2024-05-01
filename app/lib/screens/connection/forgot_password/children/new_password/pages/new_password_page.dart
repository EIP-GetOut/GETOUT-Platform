/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/screens/connection/widgets/fields_title.dart';
import 'package:getout/screens/connection/forgot_password/widgets/fields.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/widgets/show_snack_bar.dart';

class NewPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageController;

  NewPasswordPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: AutoSizeText(' MOT DE PASSE OUBLIÉ'.padRight(21, String.fromCharCodes([0x00A0, 0x0020])),
            maxLines: 1, minFontSize: 16.0, maxFontSize: 32.0),
        leading: BackButton(onPressed: () => pageController.jumpToPage(0)),
      ),
      body: BlocListener<NewPasswordBloc, NewPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {

          if (state.status.isError) {
            if (state.exception is DioException && (state.exception as DioException).response != null &&
                (state.exception as DioException).response!.statusCode == HttpStatus.INTERNAL_SERVER_ERROR) {
              showSnackBar(context, 'Le code est incorrect');
            } else {
              showSnackBar(context, 'Une erreur s\'est produite, veuillez reesayer plus tard');
            }
          }
          if (state.status.isSuccess) {
            Navigator.pop(context);
          }
        },
        child: Form(
              key: _formKey,
              child: Column(children: [
                    const SizedBox(height: 30),
                    fieldTitle(appL10n(context)!.code.toUpperCase()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: CodeField(),
                    ),
                    const SizedBox(height: 15),
                    fieldTitle(appL10n(context)!.password.toUpperCase()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: PasswordField(),
                    ),
                    const SizedBox(height: 15),
                    fieldTitle(appL10n(context)!.confirm_password_hint.toUpperCase()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: ConfirmPasswordField(),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                  ]),
            ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ForgotPasswordButton(formKey: _formKey)
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context)
  {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      builder: (context, state) {
        return state.status.isLoading
            ? const CircularProgressIndicator()
            : SizedBox(
            width: 90 * phoneWidth / 100,
            height: 65,
            child: FloatingActionButton(
              shape: Theme.of(context).floatingActionButtonTheme.shape,
              backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<NewPasswordBloc>().add(ForgotPasswordSubmitted());
                }
              },
              child: Text(appL10n(context)!.edit_password,
                  style: const TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ));
      },
    );
  }
}
