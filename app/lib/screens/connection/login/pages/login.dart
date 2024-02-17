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
import 'package:getout/screens/connection/login/widgets/fields.dart';
import 'package:getout/screens/connection/widgets/fields_title.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/tools/status.dart';

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
            showSnackBar(context, 'Le mot de passe ou l\'email est incorrect');
          } else {
            showSnackBar(context,
                'Une erreur s\'est produite, veuillez reesayer plus tard');
          }
        }
        if (state.status.isSuccess) {
          context.read<SessionBloc>().add(const SessionRequest());
        }
      },
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/entire_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 30),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text('ADRESSE EMAIL',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text('*',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: EmailField()),
              const SizedBox(height: 20),
              fieldTitle('MOT DE PASSE'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: PasswordField(),
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
                      'assets/separation. png',
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
                  child: const Text.rich(
                    TextSpan(
                      text: 'Première connection ?',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' Créer un compte',
                          style: TextStyle(
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
                  child: const Text.rich(
                    TextSpan(
                      text: 'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' Changez le',
                          style: TextStyle(
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
    final double phoneWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return (state.status.isLoading)
            ? const CircularProgressIndicator()
            : SizedBox(
                width: 90 * phoneWidth / 100,
                height: 65,
                child: FloatingActionButton(
                  child: Text('Se connecter',
                      style: Theme.of(context).textTheme.labelMedium),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  },
                ));
      },
    );
  }
}
