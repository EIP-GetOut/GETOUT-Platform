/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/screens/connection/widgets/fields_title.dart';
import 'package:getout/screens/connection/forgot_password/bloc/new_password/forgot_password_new_password_bloc.dart';
import 'package:getout/screens/connection/forgot_password/widgets/fields.dart';
import 'package:getout/screens/connection/forgot_password/bloc/form_submit_status.dart';
import 'package:getout/screens/connection/login/pages/login.dart';
import 'package:getout/constants/http_status.dart';

class ForgetPasswordChangeScreen extends StatelessWidget {
  ForgetPasswordChangeScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSnackBar(final BuildContext context, final String message)
  {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(message,
            style: Theme.of(context).textTheme.displaySmall));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('MOT DE PASSE OUBLIÉ'),
        leading: const BackButton(),
      ),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listenWhen: (previous, current) => previous.formStatus != current.formStatus,
        listener: (context, state) {
          final formStatus = state.formStatus;

          if (formStatus is SubmissionFailed) {
            if (formStatus.exception is DioException && (formStatus.exception as DioException).response != null &&
                (formStatus.exception as DioException).response!.statusCode == HttpStatus.INTERNAL_SERVER_ERROR) {
              _showSnackBar(context, 'Le code est incorrect');
            } else {
              _showSnackBar(context, 'Une erreur s\'est produite, veuillez reesayer plus tard');
            }
          }
          if (formStatus is SubmissionSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        child: Form(
              key: _formKey,
              child: Column(children: [
                    const SizedBox(height: 30),
                    fieldTitle('CODE'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: CodeField(),
                    ),
                    const SizedBox(height: 15),
                    fieldTitle('MOT DE PASSE'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: PasswordField(),
                    ),
                    const SizedBox(height: 15),
                    fieldTitle('CONFIRMEZ VOTRE MOT DE PASSE'),
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
  const ForgotPasswordButton({Key? key, required this.formKey}) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context)
  {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : SizedBox(
            width: 90 * phoneWidth / 100,
            height: 65,
            child: FloatingActionButton(
              shape: Theme.of(context).floatingActionButtonTheme.shape,
              backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmitted());
                }
              },
              child: const Text('Changer de mot de passe',
                  style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ));
      },
    );
  }
}
