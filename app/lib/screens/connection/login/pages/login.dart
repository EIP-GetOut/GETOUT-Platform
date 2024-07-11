/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/screens/connection/forgot_password/children/check_email/bloc/check_email_bloc.dart';
import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_provider.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/connection/register/pages/register.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/widgets/page_title.dart';
import 'package:getout/widgets/fields/widgets/default_button.dart';
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/constants/http_status.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ///
    /// StoreR
    ///
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          if (state.exception is DioException &&
              (state.exception as DioException).response != null &&
              (state.exception as DioException).response!.statusCode ==
                  HttpStatus.FORBIDDEN) {
            showSnackBar(context, appL10n(context)!.error_password_email);
          } else {
            showSnackBar(context, appL10n(context)!.error_unknown);
          }
        }
        if (state.status.isSuccess) {
          context.read<SessionBloc>().add(const SessionRequest());
        }
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        PageTitle(
            title: appL10n(context)!.login_title,
            description: appL10n(context)!.login_label),
        const SizedBox(height: 30),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: LoginEmailField()),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: LoginPasswordField(),
              ),
              const SizedBox(height: 30),
              Align(
                  alignment: Alignment.center,
                  child: LoginButton(formKey: _formKey)),
              const SizedBox(height: 30),
              SizedBox(
                child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/other/split.png',
                      fit: BoxFit.contain,
                    )),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                          value: BlocProvider.of<RegisterBloc>(context),
                          child: RegisterPage());
                    }));
                  },
                  child: Text.rich(
                    TextSpan(
                      text: appL10n(context)!.first_connection,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: <InlineSpan>[
                        TextSpan(
                          text: appL10n(context)!.create_account,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(213, 86, 65, 0.992)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return MultiBlocProvider(providers: [
                        BlocProvider.value(
                            value: BlocProvider.of<CheckEmailBloc>(context)),
                        BlocProvider.value(
                            value: BlocProvider.of<NewPasswordBloc>(context)),
                      ], child: const ForgotPasswordProvider());
                    }));
                  },
                  child: Text.rich(
                    TextSpan(
                      text: '${appL10n(context)!.forgot_password} ?',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' ${appL10n(context)!.change_it}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(213, 86, 65, 0.992)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    ));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return (state.status.isLoading)
            ? const CircularProgressIndicator()
            : DefaultButton(
                title: appL10n(context)!.sign_in,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                });
      },
    );
  }
}
