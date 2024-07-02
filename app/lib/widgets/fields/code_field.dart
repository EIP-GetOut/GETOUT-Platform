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
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CodeField({
    super.key,
    this.validator,
    required this.onChanged,
    required this.controller});


  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'CODE',
        mandatory: true,
        controller: controller,
        label: 'Entrez le code reçu par email',
        validator: validator);
  }
}