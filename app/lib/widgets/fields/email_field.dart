/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';

class EmailField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const EmailField({
    super.key,
    this.validator,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrez votre adresse email',
        controller: controller,
        validator: validator);
  }
}

class NewEmailField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;


  const NewEmailField({
    super.key,
    this.validator,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'NOUVELLE ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrer votre nouvelle adresse email',
        controller: controller,
        validator: validator);
  }
}

class ConfirmEmailField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const ConfirmEmailField({
    super.key,
    this.validator,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'CONFIRMATION D\'ADRESSE EMAIL',
        mandatory: true,
        label: 'Confirmer votre adresse email',
        controller: controller,
        validator: validator);
  }
}
