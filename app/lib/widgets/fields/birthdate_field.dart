/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';

class BirthdateField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const BirthdateField({super.key,
    this.validator,
    required this.onChanged,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'Date de naissance',
        mandatory: true,
        label: 'Entrez votre date de naissance',
        validator: validator,
        controller: controller);
  }

}
