/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/screens/connection/forgot_password/widgets/fields.dart';
import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:getout/screens/connection/forgot_password/pages/forgot_password_change.dart';


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSnackBar(final BuildContext context, final String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
            listenWhen: (previous, current) => previous.formStatus != current.formStatus,
            listener: (context, state) {
              final formStatus = state.formStatus;

              if (formStatus is SubmissionFailed) {
                /// TODO: Handle more errors (like no internet connection)
                if (formStatus.exception is DioException) {
                  _showSnackBar(context, 'L\'email est incorrect');
                } else {
                  _showSnackBar(context, 'Une erreur s\'est produite, veuillez reesayer plus tard');
                }
              }
              if (formStatus is SubmissionSuccess) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordChangePage()));
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.black, //change your color here
                ),
                centerTitle: true,
                titleSpacing: 0,
                title: Text(
                  'MOT DE PASSE OUBLIÉ'.padRight(
                      '             '.length,
                      String.fromCharCodes([0x00A0 /*No-Break Space*/ ])), // don't know but print white space,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                leading: const BackButton(),
                backgroundColor: Colors.white10,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: EmailField(),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  ForgotPasswordButton(formKey: _formKey),
                ]),
              )),
            )));
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key, required this.formKey}) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<ForgotPasswordBloc>().add(ForgotPasswordSubmitted());
              }
            },
            child: const Text('Recevoir un code')//SocialMediaSpentTime(),
        );
      },
    );
  }
}
