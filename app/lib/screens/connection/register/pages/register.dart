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
import 'package:getout/screens/form/pages/social_media_spent_time.dart';

/*
import 'package:getout/models/connection/create_account.dart';
import 'package:getout/screens/form/pages/welcome.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/constants/http_status.dart';
import 'package:getout/widgets/load.dart';
*/
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSnackBar(final BuildContext context, final String message) {
    final snackBar = SnackBar(content: Text(message));
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
                /// TODO: Handle more errors (like no internet connection)
                if (formStatus.exception is DioException) {
                  _showSnackBar(context, 'Une erreur serveur s\'est produite veuillez reesayer plus tard');
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
                iconTheme: const IconThemeData(
                  color: Colors.black, //change your color here
                ),
                centerTitle: true,
                titleSpacing: 0,
                title: Text(
                    'VOTRE PROFIL',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall),
                leading: const BackButton(),
                backgroundColor: Colors.white10,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: LastNameField()),
                          const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: FirstNameField()),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: BornDateField()),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: EmailField(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: PasswordField(),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          RegisterButton(formKey: _formKey),
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
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<RegisterBloc>().add(RegisterSubmitted());
              }
            },
            child: const Text('S\'inscrire')//SocialMediaSpentTime(),
        );
      },
    );
  }
}


/*class _RegisterPageState extends State<RegisterPage> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController bornDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final HttpStatus httpStatus = HttpStatus({
    HttpStatus.INTERNAL_SERVER_ERROR:
        'Une erreur s\'est produite, veuillez réesayer plus tard',
    HttpStatus.CONFLICT: 'Un compte avec cet email existe déjà',
    HttpStatus.NO_INTERNET: 'Pas de connexion internet',
  });

  Future<void> registerPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    RequestsService.instance
        .register(CreateAccountRequest(
            email: emailController.text,
            password: passwordController.text,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            bornDate: bornDateController.text))
        .then((AccountResponseInfo res) {
      if (res.statusCode == AccountResponseInfo.success) {
        isLoading = false;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WelcomePage()));
        return;
      }
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(httpStatus.getMessage(res.statusCode)),
          backgroundColor: const Color.fromARGB(255, 239, 46, 46)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadPage()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              centerTitle: true,
              titleSpacing: 0,
              title: Text(
                'VOTRE PROFIL',
                style: Theme.of(context).textTheme.titleSmall),
              leading: const BackButton(),
              backgroundColor: Colors.white10,
              elevation: 0,
            ),
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// TODO a loop for all fields (padding with each field)
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: NameField(controller: lastNameController)),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: FirstNameField(controller: firstNameController)),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: BirthDateField(controller: bornDateController)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: MailField(controller: emailController),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: PasswordField(controller: passwordController),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: SecondPasswordField(
                            controller: password2Controller,
                            fstPassword: passwordController.text)),
                    const SizedBox(
                      height: 70,
                    ),
                    startButton(context, MediaQuery.of(context).size.width),
                  ]),
            )),
          );
  }

  Widget startButton(BuildContext context, double phoneWidth) {
    return SizedBox(
        width: 85 * phoneWidth / 100,
        height: 65,
        child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            backgroundColor: const Color.fromRGBO(213, 86, 65, 0.992),
            onPressed: registerPressed,
            child: const Text('S\'inscrire',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ))));
  }
}*/
