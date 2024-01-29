/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

class PasswordConnectionField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordConnectionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
            // hintText: 'Entrez votre mot de passe',
            labelText: 'Mot de passe',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Un prénom est requis';
        //   }
        //   return null;
        // }
        );
  }
}

class MailField extends StatelessWidget {
  final TextEditingController controller;

  const MailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: false,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Entrez votre email',
            labelText: 'Email',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )),
        validator: MultiValidator([
          RequiredValidator(errorText: 'Un email est requis'),
          EmailValidator(errorText: 'Entrez une addresse email valide')
        ]).call);
  }
}

class CodeField extends StatelessWidget {
  final TextEditingController controller;

  const CodeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Entrez votre mot de passe',
            labelText: 'Code',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )),
        validator: MultiValidator([
          RequiredValidator(errorText: 'Un mot de passe est requis'),
          LengthRangeValidator(min: 6, max:6,
              errorText:
              'Le code contient 6 chiffres'),
          PatternValidator(r'(^[0-9]*$)',
              errorText:
              'Le code contient uniquement des chiffres'),
        ]).call);
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Entrez votre mot de passe',
            labelText: 'Mot de passe',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )),
        validator: MultiValidator([
          RequiredValidator(errorText: 'Un mot de passe est requis'),
          MinLengthValidator(12,
              errorText:
                  'Votre mot de passe doit contenir au moins 12 caractères'),
          PatternValidator(r'(?=.*?[#?!@$%^&*-])',
              errorText:
                  'Votre mot de passe doit contenir au moins un caractère spécial'),
          PatternValidator(r'([A-Z])',
              errorText:
                  'Votre mot de passe doit contenir au moins une majuscule'),
          PatternValidator(r'([a-z])',
              errorText:
                  'Votre mot de passe doit contenir au moins une miniscule'),
          PatternValidator(r'([0-9])',
              errorText:
                  'Votre mot de passe doit contenir au moins un chiffre'),
        ]).call);
  }
}

class SecondPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String fstPassword;

  const SecondPasswordField(
      {super.key, required this.controller, required this.fstPassword});

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Vous devez confirmer votre mot de passe';
    } else if (value != fstPassword) {
      return 'Les mots de passe ne correspondent pas';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Confirmez votre mot de passe',
            labelText: 'Confirmez votre mot de passe',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )),
        validator: (value) {
          if (value == null) {
            return 'Un mot de passe est requis';
          }
          return validatePassword(value);
        });
  }
}

class FirstNameField extends StatelessWidget {
  final TextEditingController controller;

  const FirstNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: false,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Entrez votre prénom',
            labelText: 'Prénom',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Un prénom est requis';
          }
          return null;
        });
  }
}

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: false,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Entrez votre nom',
            labelText: 'Nom',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Un nom est requis';
          }
          return null;
        });
  }
}

class BirthDateField extends StatelessWidget {
  final TextEditingController controller;

  const BirthDateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Date de naissance',
            labelText: 'Entrez votre date de naissance',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide:
                    const BorderSide(color: Color.fromRGBO(213, 86, 65, 1)))),
        readOnly: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Une date est requise';
          }
          return null;
        },
        //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              locale: const Locale('fr', 'FR'),
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2100));

          if (pickedDate != null) {
            // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
            // print(formattedDate); //formatted date output using intl package =>  2021-03-16
            controller.text = formattedDate;
            // setState(() {
            //   pickedDate =
            //       formattedDate; //set output date to TextField value.
            // });
          }
        });
  }
}
