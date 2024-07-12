/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/fields/code_field.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';

class NewPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController pageController;
  static int tries = 0;

  NewPasswordPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: BackButton(onPressed: () => pageController.jumpToPage(0)),
      ),
        body: BlocListener<NewPasswordBloc, NewPasswordState>(
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
                  showSnackBar(context, appL10n(context)!.password_tries);
                } else {
                  showSnackBar(context, appL10n(context)!.code_incorrect);
                }
              } else if (state.exception is DioException &&
                  (state.exception as DioException).response != null &&
                  (state.exception as DioException).response!.statusCode ==
                      HttpStatus.BAD_REQUEST) {
                showSnackBar(context,
                    appL10n(context)!.password_old);
              } else {
                showSnackBar(context,
                    appL10n(context)!.error_unknown);
              }
            }
            if (state.status.isSuccess) {
              Navigator.pop(context);
              showSnackBar(
                  context, appL10n(context)!.password_edit_success,
                  color: Colors.green);
            }
          },
          child: Form(
            key: _formKey,
            child: Column(children: [
              PageTitle(title: appL10n(context)!.forgot_password, description: appL10n(context)!.forgot_password_label_next),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ForgotPasswordCodeField(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ForgotPasswordField(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: ForgotPasswordConfirmField(),
              ),
              const SizedBox(
                height: 70,
              ),
            ]),
          ),
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
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      builder: (context, state) {
        return state.status.isLoading
            ? const CircularProgressIndicator()
            : DefaultButton(
                title: appL10n(context)!.edit_password,
                onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<NewPasswordBloc>()
                          .add(ForgotPasswordSubmitted());
                    }
                  },
              );
      },
    );
  }
}
