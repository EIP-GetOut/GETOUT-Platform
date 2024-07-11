/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:getout/screens/connection/services/service.dart';
import 'package:getout/tools/app_l10n.dart';

import 'package:getout/tools/validator/field.dart';
import 'package:getout/tools/validator/email.dart';
import 'package:getout/tools/validator/password.dart';

import 'package:getout/widgets/fields/email_field.dart';
import 'package:getout/widgets/fields/name_field.dart';
//import 'package:getout/widgets/fields/birthdate_field.dart';
import 'package:getout/widgets/fields/password_field.dart';
import 'package:getout/widgets/fields/widgets/title_field.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatelessWidget {
  final ConnectionService service;
  RegisterPage({super.key, required this.service});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController birthdate = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);
    final ValueNotifier<bool> loadingRequest = ValueNotifier<bool>(false);

    final double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(appL10n(context)!.your_profile),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 30),
          Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LastNameField(
                        controller: lastName,
                        validator: (String? value) =>
                            mandatoryValidator(context, value)),
                    FirstNameField(
                        controller: firstName,
                        validator: (String? value) =>
                            mandatoryValidator(context, value)),
                    EmailField(
                        controller: email,
                        validator: (String? value) =>
                            emailValidator(context, value)),
                    //BirthdateField(
                    //    onChanged: (String value) => birthDate = value != '' ? value : birthDate,
                    //    validator: (_) => mandatoryValidator(context, birthDate)),
                    Column(
                        //todo make this a widget
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          fieldTitle('BirthDate', true),
                          //field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: SizedBox(
                                height: 64,
                                child: TextFormField(
                                  controller: birthdate,
                                  readOnly: true,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.black),
                                  decoration: InputDecoration(
                                      labelText: 'Enter BirtDate',
                                      //todo: can be used to avoid duplication (also see hintText instead of label)
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.5),
                                          borderSide: const BorderSide(
                                              color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.5))),
                                  validator: (value) =>
                                      birthdateValidator(context, value),
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        locale: const Locale('fr', 'FR'),
                                        initialDate: (birthdate.text != '')
                                            ? DateFormat('dd/MM/yyyy')
                                                .parse(birthdate.text)
                                            : DateTime.now(),
                                        firstDate: DateTime.now().subtract(
                                            const Duration(days: 365 * 150)),
                                        lastDate: DateTime.now());

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                      birthdate.text = formattedDate;
                                    }
                                  },
                                )),
                          )
                        ]),
                    NewPasswordField(
                        controller: password,
                        validator: (value) =>
                            newPasswordValidator(context, value)),
                    ValueListenableBuilder<String?>(
                        valueListenable: errorMessage,
                        builder: (context, value, child) {
                          return ConfirmPasswordField(
                              controller: confirmPassword,
                              validator: (_) => confirmPasswordValidator(
                                  context, password.text, confirmPassword.text),
                              errorString: value);
                        })
                  ])),
          const SizedBox(height: 50),
          ValueListenableBuilder<bool>(
              valueListenable: loadingRequest,
              builder: (_, value, child) {
                return Align(
                    alignment: Alignment.center,
                    child: (value)
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 90 * phoneWidth / 100,
                            height: 65,
                            child: FloatingActionButton(
                              child: Text(appL10n(context)!.create_account,
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  loadingRequest.value = true;
                                  print(
                                      'register: email=${email.text}, first=${firstName.text}, last=${lastName.text}, birth=${birthdate.text}, pass=${password.text}, confirmPass:${confirmPassword.text}.');
                                  try {
                                    Response response = await service
                                        .register(RegisterRequestModel(
                                      email: email.text,
                                      password: password.text,
                                      firstName: firstName.text,
                                      lastName: lastName.text,
                                      birthDate: birthdate.text,
                                    ));
                                    if (response.statusCode == 201) {
                                      //succes
                                      //todo createAccount & maybePop()
                                      errorMessage.value = null;
                                      Navigator.maybePop(
                                          context); //todo https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps
                                    }
                                  } catch (e) {
                                    if (e is DioException &&
                                        e.response != null &&
                                        e.response!.statusCode != null) {
                                      switch (e.response?.statusCode) {
                                        case 400:
                                          errorMessage.value =
                                              'Les valeurs entrées sont invalide';
                                          break;
                                        case 500:
                                          errorMessage.value =
                                              'Le serveur n\'a pas réussi à traiter la demande';
                                          break;
                                        default:
                                          errorMessage.value =
                                              'Une erreur est survenu';
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
              })
        ]),
      )),
    ));
  }
}
