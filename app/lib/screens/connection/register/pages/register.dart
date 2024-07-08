/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/screens/connection/register/widgets/fields.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/fields/name_field.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/constants/http_status.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isError) {
                if (state.exception is DioException &&
                    (state.exception as DioException).response != null &&
                    (state.exception as DioException).response!.statusCode ==
                        HttpStatus.CONFLICT) {
                  showSnackBar(context,
                      'Un compte avec cette adresse email existe déjà');
                } else {
                  showSnackBar(context, appL10n(context)!.error_unknown);
                }
              }
              if (state.status.isSuccess) {
                Navigator.pop(context);
                showSnackBar(context, appL10n(context)!.account_created,
                    color: Colors.green);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                // title: Text(appL10n(context)!.your_profile),
                leading: const BackButton(),
              ),
              body: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PageTitle(
                          title: appL10n(context)!.register_title,
                          description: appL10n(context)!.register_label),
                      const SizedBox(height: 30),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: RegisterLastNameField()),
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: RegisterFirstNameField()),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: BirthDateField()),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: RegisterEmailField(),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: RegisterPasswordField(),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: RegisterConfirmPasswordField(),
                      ),
                      const SizedBox(height: 30),
                      Align(
                          alignment: Alignment.center,
                          child: RegisterButton(formKey: _formKey)),
                      const SizedBox(height: 15),
                    ]),
              )),
            )));
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isLoading
            ? const CircularProgressIndicator()
            : DefaultButton(
                title: appL10n(context)!.next,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<RegisterBloc>().add(RegisterSubmitted());
                  }
                });
      },
    );
  }
}
