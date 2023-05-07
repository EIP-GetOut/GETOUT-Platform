/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

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
                      borderRadius: BorderRadius.circular(0.5),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.5),

                  )
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Un email est requis'),
                EmailValidator(errorText: 'Entrez une addresse email valide')
              ])
          ),
        ],
        ));
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final formKey;
  final Key key = UniqueKey();

  PasswordField({super.key, required this.formKey, required this.controller});

  String ?validatePassword(String value) {
    if (value.isEmpty) {
      return 'Un mot de passe est requis';
    } else if (value.length < 12) {
      return 'Un mot de passe doit contenir au moins 12 caractères';
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
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            )
          ),
          validator: MultiValidator([
            RequiredValidator(errorText: 'Un mot de passe est requis'),
            MinLengthValidator(12, errorText: 'Votre mot de passe doit contenir au moins 12 caractères'),
            PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Votre mot de passe doit contenir au moins un caractère spécial'),
            PatternValidator(r'([A-Z])', errorText: 'Votre mot de passe doit contenir au moins une majuscule'),
            PatternValidator(r'([a-z])', errorText: 'Votre mot de passe doit contenir au moins une miniscule'),
            PatternValidator(r'([0-9])', errorText: 'Votre mot de passe doit contenir au moins un chiffre'),
          ])
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
      return 'Vous devez confirmer votre mot de passe';
    } else if (value != fstPassword) {
      return 'Les mots de passe ne correspondent pas';
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
                  hintText: 'Confirmez votre mot de passe',
                  labelText: 'Confirmez votre mot de passe',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.5),

                  )
              ),
              validator: (value) {
                if (value == null) {
                  return 'Un mot de passe est requis';
                }
                  return validatePassword(value);
                }
          ),
        ],
        ));
  }
}

class FirstNameField extends StatelessWidget {
  final TextEditingController controller;
  final formKey;

  const FirstNameField({super.key, required this.formKey, required this.controller});

  String ?validateName(String value) {
    if (value.isEmpty) {
      return 'Un prénom est requis';
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
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Entrez votre prénom',
                  labelText: 'Prénom',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),

                  )
              ),
              validator: (value) {
                if (value == null) {
                  return 'Un prénom est requis';
                }
                return validateName(value);
              }
          ),
        ],
        ));
  }
}

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final formKey;

  const NameField({super.key, required this.formKey, required this.controller});

  String ?validateName(String value) {
    if (value.isEmpty) {
      return 'Un nom est requis';
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
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'Entrez votre nom',
                  labelText: 'Nom',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),

                  )
              ),
              validator: (value) {
                if (value == null) {
                  return 'Un nom est requis';
                }
                return validateName(value);
              }
          ),
        ],
        ));
  }
}

class BirthDateField extends StatelessWidget {
  final TextEditingController controller;
  final formKey;

  const BirthDateField({super.key, required this.formKey, required this.controller});

  String ?validateBirth(String value) {
    if (value.isEmpty) {
      return 'Une date est requise';
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
              decoration: InputDecoration(
                  hintText: 'Date de naissance',
                  labelText: 'Entrez votre date de naissance',
                  
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),
                      borderSide: const BorderSide(color: Color.fromRGBO(213, 86, 65, 1))
                  )
              ),
              readOnly: true,
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
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  controller.text = formattedDate;
                  // setState(() {
                  //   pickedDate =
                  //       formattedDate; //set output date to TextField value.
                  // });
                }
                
                validator: (value) {
                if (value == null) {
                  return 'Une date est requise';
                }
                return validateBirth(value);
              };
            }
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
                      borderRadius: BorderRadius.circular(0.5),
                      borderSide: const BorderSide(color: Colors.black)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.5),

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
