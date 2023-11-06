/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/screens/form/pages/social_media_spent_time.dart';
import 'package:getout/screens/connection/forgot_password/pages/forgot_password_code.dart';
import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_service.dart';
import 'package:getout/screens/connection/register/pages/register.dart';
import 'package:getout/screens/connection/register/bloc/register_service.dart';
import 'package:getout/screens/connection/login/widgets/fields.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSnackBar(final BuildContext context, final String message)
  {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current) =>
            previous.formStatus != current.formStatus,
            listener: (context, state) {
              final formStatus = state.formStatus;

              if (formStatus is SubmissionFailed) {
                /// TODO: Handle more errors (like no internet connection)
                if (formStatus.exception is DioException) {
                  _showSnackBar(context, 'Le mot de passe ou l\'email est incorrect');
                } else {
                  _showSnackBar(context, 'Une erreur s\'est produite, veuillez reesayer plus tard');
                }
              }
              if (formStatus is SubmissionSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SocialMediaSpentTime()));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 10),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: EmailField(),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              SizedBox(
                                  width: 10),
                              Text('MOT DE PASSE',
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: PasswordField(),
                          ),
                          const SizedBox(height: 30),
                          LoginButton(formKey: _formKey),
                          const SizedBox(height: 30),
                          SizedBox(
                            child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/separation.png',
                                  fit: BoxFit.contain,
                                )),
                          ),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RepositoryProvider(
                                          create: (context) => RegisterService(),
                                          child: RegisterScreen())));
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Première connection ?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' Créer un compte',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                              213, 86, 65, 0.992)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RepositoryProvider(
                                            create: (context) => ForgotPasswordService(),
                                            child: ForgotPasswordScreen())));
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Mot de passe oublié ?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' Changez le',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                              213, 86, 65, 0.992)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ]),));
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.formKey}) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                child: const Text('Se connecter')//SocialMediaSpentTime(),
        );
      },
    );
  }
}
