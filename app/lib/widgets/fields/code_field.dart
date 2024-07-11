/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';

class CodeField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? errorString;

  const CodeField({
    super.key,
    this.validator,
    required this.controller,
    this.errorString});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'CODE',
        mandatory: true,
        controller: controller,
        errorString: errorString,
        label: 'Entrez le code reçu par email',
        validator: validator);
  }
}