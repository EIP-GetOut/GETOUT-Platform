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
  //final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? errorString;

  const PasswordField({
    super.key,
    this.validator,
    required this.controller,
    this.errorString});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'MOT DE PASSE',
        mandatory: true,
        controller: controller,
        label: 'Entrez votre mot de passe',
        obscure: true,
        validator: validator,
        errorString: errorString);
  }
}

class NewPasswordField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const NewPasswordField({
    super.key,
    this.validator,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'NOUVEAU MOT DE PASSE',
        mandatory: true,
        controller: controller,
        label: 'Entrez votre nouveau mot de passe',
        obscure: true,
        validator: validator);
  }
}

class ConfirmPasswordField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? errorString;

  const ConfirmPasswordField({
    super.key,
    this.validator,
    required this.controller,
    this.errorString});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'CONFIRMATION DE MOT DE PASSE',
        mandatory: true,
        controller: controller,
        label: 'Confirmer votre mot de passe',
        obscure: true,
        validator: validator,
        errorString: errorString);
  }
}

/*class NewPassword2Field extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onChangedConfirm;
  final String? Function(String?)? validator;

  const NewPassword2Field({super.key, this.validator, this.validatorConfirm, required this.onChanged, required this.onChangedConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DefaultField(
          title: 'NOUVEAU MOT DE PASSE',
          mandatory: true,
          label: 'Entrez votre nouveau mot de passe',
          obscure: true,
          validator: validator,
          onChanged: onChanged),
      DefaultField(
          title: 'NOUVEAU MOT DE PASSE',
          mandatory: true,
          label: 'Entrez votre nouveau mot de passe',
          obscure: true,
          validator: validatorConfirm,
          onChanged: onChangedConfirm),
    ]);
  }
}*/
