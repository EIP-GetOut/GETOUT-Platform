/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';

import '../../tools/app_l10n.dart';


class LastNameField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const LastNameField({
    super.key,
    this.validator,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: appL10n(context)!.lastname,
        mandatory: true,
        controller: controller,
        label: appL10n(context)!.lastname_hint,
        validator: validator);
  }
}

class FirstNameField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const FirstNameField({
    super.key,
    this.validator,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: appL10n(context)!.lastname,
        mandatory: true,
        controller: controller,
        label: appL10n(context)!.lastname_hint,
        validator: validator);
  }
}