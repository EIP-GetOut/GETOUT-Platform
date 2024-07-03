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
import 'package:getout/constants/http_status.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/status.dart';


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
                if (state.exception is DioException && (state.exception as DioException).response != null &&
                    (state.exception as DioException).response!.statusCode == HttpStatus.CONFLICT) {
                  showSnackBar(context, 'Un compte avec cette adresse email existe déjà');
                } else {
                  showSnackBar(context, appL10n(context)!.error_unknow);
                }
              }
              if (state.status.isSuccess) {
                Navigator.pop(context);
                showSnackBar(context, appL10n(context)!.account_created, color: Colors.green);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: Text(appL10n(context)!.your_profile),
                leading: const BackButton(),
              ),
              body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: RegisterLastNameField()),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: RegisterFirstNameField()),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BirthDateField()),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: RegisterEmailField(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: RegisterPasswordField(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: RegisterConfirmPasswordField(),
                          ),
                          const SizedBox(height: 50),
                          Align(
                              alignment: Alignment.center,
                              child: RegisterButton(formKey: _formKey)
                          ),
                        ]),
                  )),
            )
        )
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context)
  {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isLoading
            ? const CircularProgressIndicator()
            : SizedBox(
            width: 90 * phoneWidth / 100,
            height: 65,
            child: FloatingActionButton(
              child: Text(appL10n(context)!.next, style: Theme.of(context).textTheme.labelMedium),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(RegisterSubmitted());
                }
              },
            ));
      },
    );
  }
}
