/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/connection/forgot_password/pages/forgot_password_page.dart';

import 'package:getout/screens/connection/register/pages/register.dart';
import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/screens/connection/widgets/action_string.dart';

import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/tools.dart';
import 'package:getout/tools/validator/field.dart';
import 'package:getout/tools/validator/email.dart';
import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/password_field.dart';

import 'package:getout/bloc/user/user_bloc.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final ConnectionService service;

  LoginPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);
    final ValueNotifier<bool> loadingRequest = ValueNotifier<bool>(false);

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/logo/full_getout.png',
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 30),
            Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //              mainAxisAlignment: MainAxisAlignment.center, todo remove scroll or set height.
                    children: [
                      EmailField(
                          validator: (_) => emailValidator(context, email.text),
                          controller: email),
                      ValueListenableBuilder<String?>(
                          valueListenable: errorMessage,
                          builder: (context, value, child) {
                            return PasswordField(
                                validator: (_) =>
                                    mandatoryValidator(context, password.text),
                                controller: password,
                                errorString: value);
                          })
                    ])),
            const SizedBox(height: 30),
            ValueListenableBuilder<bool>(
                valueListenable: loadingRequest,
                builder: (context, value, child) {
                  return Align(
                      alignment: Alignment.center,
                      child: (value)
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: Tools.widthFactor(context, 0.90),
                              height: 65,
                              child: FloatingActionButton(
                                child: Text(appL10n(context)!.sign_in,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                onPressed: () async {
                                  errorMessage.value = null;
                                  if (formKey.currentState!.validate()) {
                                    //login
                                    try {
                                      loadingRequest.value = true;
                                      //context.read<UserBloc>().add(const LoadingEvent());
                                      Response response = await service.login(
                                          LoginRequestModel(
                                              email: email.text,
                                              password: password.text));
                                      if (response.statusCode == 200) {
                                        context.read<UserBloc>().add(const LoginEvent());
                                        //context.read<UserBloc>().add(const SessionEvent());
                                        //todo update UserCookie isSet
                                      }
                                    } catch (e) {
                                      if (e is DioException &&
                                          e.response != null &&
                                          e.response!.statusCode != null) {
                                        switch (e.response?.statusCode) {
                                          case 400:
                                            //errorMessage.value = 'Il semblerait que le téléphone soit déja connecter';
                                            context.read<UserBloc>().add(const LoginEvent());
                                            break;
                                          case 401:
                                            errorMessage.value =
                                                'L\'email et le mot de passe ne corespondent pas';
                                            break;
                                          case 500:
                                            errorMessage.value =
                                                'Le serveur n\'a pas réussi à traiter la demande';
                                            break;
                                          default:
                                            errorMessage.value =
                                                'L\'email ou le mot de passe est incorrect';
                                        }
                                      } else {
                                        errorMessage.value =
                                            'Une erreur est survenu';
                                      }
                                    }
                                    loadingRequest.value = false;
                                  }
                                },
                              )));
                }),
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
            ActionString(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return RegisterPage(service: service);
                  }));
                },
                question: '${appL10n(context)!.first_connection} ? ',
                action: appL10n(context)!.create_account),
            const SizedBox(height: 30),
            ActionString(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ForgotPasswordPage(service: service);
                  }));
                },
                question: '${appL10n(context)!.forgot_password} ? ',
                action: appL10n(context)!.change_it),
          ]),
        ),
      ]),
    );
  }
}
