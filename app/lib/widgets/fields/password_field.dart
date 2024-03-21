/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/widgets/fields/widgets/default_field.dart';

class PasswordField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const PasswordField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre mot de passe',
        validator: validator,
        onChanged: onChanged);
  }
}

class NewPasswordField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const NewPasswordField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'NOUVEAU MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre nouveau mot de passe',
        validator: validator,
        onChanged: onChanged);
  }
}

class ConfirmPasswordField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const ConfirmPasswordField(
      {super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'CONFIRMATION DE MOT DE PASSE',
        mandatory: true,
        label: 'Confirmer votre mot de passe',
        validator: validator,
        onChanged: onChanged);
  }
}
