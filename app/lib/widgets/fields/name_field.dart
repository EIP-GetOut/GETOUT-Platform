/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/tools/app_l10n.dart';

class RegisterLastNameField extends StatelessWidget {
  const RegisterLastNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DefaultField(
        title: 'NOM',
        mandatory: true,
        label: 'Entrez votre nom',
          validator: (value) =>
          state.isLastNameEmpty ? null : appL10n(context)!.lastname_validator,
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterLastNameChanged(lastName: value),
          ));
    });
  }
}

class RegisterFirstNameField extends StatelessWidget {
  const RegisterFirstNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DefaultField(
        title: 'PRÉNOM',
        mandatory: true,
        label: 'Entrez votre prénom',
          validator: (value) =>
          state.isFirstNameEmpty ? null : appL10n(context)!.firstname_validator,
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterFirstNameChanged(firstName: value),
          ));
    });
  }
}
