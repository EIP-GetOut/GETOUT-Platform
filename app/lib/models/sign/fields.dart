/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final formKey;
  final Key key = UniqueKey();

  PasswordField({super.key, required this.formKey, required this.controller});

  String ?validatePassword(String value) {
    if (value.isEmpty) {
      return "A password is required";
    } else if (value.length < 8) {
      return "Password should be at least 8 characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
    key: formKey,
        child : Column(children: [
          TextFormField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Entrez votre mot de passe',
              labelText: 'Mot de passe',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue)
            )
          ),
          validator: (value) {
            if (value == null) {
              return 'A password is required';
            }
            return validatePassword(value);
          }
          ),
        ],
      ));
    }
}

class SecondPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final formKey;
  final String fstPassword;

  const SecondPasswordField({super.key, required this.formKey, required this.controller, required this.fstPassword});

  String ?validatePassword(String value) {
    if (value.isEmpty) {
      return 'un mot de passe est requis';
    } else if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    } else if (value != fstPassword) {
      return 'les mots de passe ne correspondent pas';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child : Column(children: [
          TextFormField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Retapez votre Mot de passe',
                  labelText: 'Retapez votre Mot de passe',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)
                  )
              ),
              validator: (value) {
                if (value == null) {
                  return 'un mot de passe est requis';
                }
                return validatePassword(value);
              }
          ),
        ],
        ));
  }
}

class MailField extends StatelessWidget {
  final TextEditingController controller;
  final formKey;

  const MailField({super.key, required this.formKey, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child : Column(children: [
          TextFormField(
            controller: controller,
            obscureText: false,
            decoration: InputDecoration(
                hintText: 'Entrez votre email',
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue)
                )
            ),
            validator: MultiValidator([
              RequiredValidator(errorText: 'un email est requis'),
              EmailValidator(errorText: 'Entrez une addresse email valide')
            ])
          ),
        ],
        ));
  }
}

class MyField extends StatelessWidget {
  final TextEditingController? controller;
  final formKey = GlobalKey();
  final Key key = UniqueKey();
  final String ?name;

  MyField({super.key, required this.controller, required this.name});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child : Column(children: [
          TextFormField(
              controller: controller,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: name,
                  labelText: name,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)
                  )
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'une info est requise';
                }
                return null;
              }
          ),
        ],
        ));
  }
}
