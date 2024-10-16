/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/connection/forgot_password/pages/check_email/bloc/check_email_bloc.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/widgets/page_title.dart';

class CheckEmailPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageController;

  CheckEmailPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.pop(context)),
        ),
        body: BlocListener<CheckEmailBloc, CheckEmailState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isError) {
             if (state.statusCode == HttpStatus.INTERNAL_SERVER_ERROR ||
                        state.statusCode == HttpStatus.UNPROCESSABLE_ENTITY) {
                showSnackBar(context, appL10n(context)!.email_validator);
              } else if (state.statusCode == HttpStatus.APP_TIMEOUT) {
                showSnackBar(context, 'Timeout'); /// TODO create a timeout message
              } else {
                showSnackBar(context, appL10n(context)!.error_unknown);
              }
            }
            if (state.status.isSuccess) {
              pageController.jumpToPage(1);
            }
          },
          child: Column(children: [
            PageTitle(
                title: appL10n(context)!.forgot_password,
                description: appL10n(context)!.forgot_password_label),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ForgotPasswordEmailField(),
              ),
            )
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ForgotPasswordButton(formKey: _formKey));
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CheckEmailBloc, CheckEmailState>(
      builder: (context, state) {
        return state.status.isLoading
            ? const CircularProgressIndicator()
            : DefaultButton(
                title: appL10n(context)!.receive_code,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<CheckEmailBloc>().add(CheckEmailSubmitted());
                  }
                },
              );
      },
    );
  }
}
