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
import 'package:getout/screens/connection/forgot_password/bloc/email/forgot_password_email_bloc.dart';
import 'package:getout/screens/connection/forgot_password/bloc/form_submit_status.dart';
import 'package:getout/screens/connection/forgot_password/pages/new_password_page.dart';
import 'package:getout/screens/connection/widgets/fields_title.dart';
import 'package:getout/constants/http_status.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  ForgotPasswordEmailScreen({Key? key}) : super(key: key);

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
  Widget build(BuildContext context)
  {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          titleSpacing: 0,
          title: Text(
            'MOT DE PASSE OUBLIÉ'.padRight('             '.length, String.fromCharCodes([0x00A0 /*No-Break Space*/])), // don't know but print white space,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: const BackButton(),
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        body: BlocListener<ForgotPasswordEmailBloc, ForgotPasswordEmailState>(
      listenWhen: (previous, current) => previous.formStatus != current.formStatus,
      listener: (context, state) {
        final formStatus = state.formStatus;

        if (formStatus is SubmissionFailed) {
          if (formStatus.exception is DioException && (formStatus.exception as DioException).response != null &&
              (formStatus.exception as DioException).response!.statusCode == HttpStatus.INTERNAL_SERVER_ERROR) {
            _showSnackBar(context, 'L\'email est incorrect');
          } else if (formStatus.exception is DioException && (formStatus.exception as DioException).response != null &&
              (formStatus.exception as DioException).response!.statusCode == HttpStatus.UNPROCESSABLE_ENTITY) {
            _showSnackBar(context, 'L\'email n\'est pas valide');
          } else {
            _showSnackBar(context, 'Une erreur s\'est produite, veuillez reesayer plus tard');
          }
        }
        if (formStatus is SubmissionSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordChangeScreen()));
        }
      },
      child: Column(children: [
            const SizedBox(height: 40),
            fieldTitle('EMAIL'),
            Form(
              key: _formKey,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: EmailField(),
              ),
            )
          ]),
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

    return BlocBuilder<ForgotPasswordEmailBloc, ForgotPasswordEmailState>(
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
                      context.read<ForgotPasswordEmailBloc>().add(ForgotPasswordEmailSubmitted());
                    }
                  },
                  child: const Text('Recevoir un code',
                      style: TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ));
      },
    );
  }
}
