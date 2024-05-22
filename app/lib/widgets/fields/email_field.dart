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
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const EmailField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrez votre adresse email',
        validator: validator,
        onChanged: onChanged);
  }
}

class NewEmailField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const NewEmailField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'NOUVELLE ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrer votre nouvelle adresse email',
        validator: validator,
        onChanged: onChanged);
  }
}

class ConfirmEmailField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const ConfirmEmailField(
      {super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'CONFIRMATION D\'ADRESSE EMAIL',
        mandatory: true,
        label: 'Confirmer votre adresse email',
        validator: validator,
        onChanged: onChanged);
  }
}
