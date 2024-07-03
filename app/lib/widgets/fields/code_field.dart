/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const CodeField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'CODE',
        mandatory: true,
        label: 'Entrez le code reçu par email',
        validator: validator,
        onChanged: onChanged);
  }
}

class ForgotPasswordCodeField extends StatelessWidget {
  const ForgotPasswordCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(builder: (context, state) {
      return DefaultField(
        title: 'CODE',
        mandatory: true,
        label: 'Entrez le code reçu par email',
          validator: (value) =>
          state.isCodeValid ? null : appL10n(context)!.code_validator,
          onChanged: (value) => context.read<NewPasswordBloc>().add(
            ForgotPasswordCodeChanged(code: value),
          ),
        );
    });
  }
}