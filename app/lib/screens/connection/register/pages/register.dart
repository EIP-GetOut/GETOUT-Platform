/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:getout/screens/connection/widgets/fields_title.dart';
import 'package:getout/screens/connection/register/widgets/fields.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/form/pages/social_media_spent_time.dart';
import 'package:getout/constants/http_status.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSnackBar(final BuildContext context, final String message) {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(message,
            style: Theme.of(context).textTheme.displaySmall
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) =>
            previous.formStatus != current.formStatus,
            listener: (context, state) {
              final formStatus = state.formStatus;

              if (formStatus is SubmissionFailed) {
                if (formStatus.exception is DioException && (formStatus.exception as DioException).response != null &&
                    (formStatus.exception as DioException).response!.statusCode == HttpStatus.CONFLICT) {
                  _showSnackBar(context, 'Un compte avec cette adresse email existe déjà');
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
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: const Text('VOTRE PROFIL'),
                leading: const BackButton(),
              ),
              body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          fieldTitle('NOM'),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: LastNameField()),
                          const SizedBox(height: 15),
                          fieldTitle('PRÉNOM'),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: FirstNameField()),
                          const SizedBox(height: 15),
                          fieldTitle('DATE DE NAISSANCE'),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BornDateField()),
                          const SizedBox(height: 15),
                          fieldTitle('ADRESSE EMAIL'),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: EmailField(),
                          ),
                          const SizedBox(height: 15),
                          fieldTitle('MOT DE PASSE'),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: PasswordField(),
                          ),
                          const SizedBox(height: 15),
                          fieldTitle('CONFIRMEZ VOTRE MOT DE PASSE'),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: ConfirmPasswordField(),
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
  const RegisterButton({Key? key, required this.formKey}) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context)
  {
    final double phoneWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : SizedBox(
            width: 90 * phoneWidth / 100,
            height: 65,
            child: FloatingActionButton(
              child: Text('Suivant', style: Theme.of(context).textTheme.labelMedium),
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
