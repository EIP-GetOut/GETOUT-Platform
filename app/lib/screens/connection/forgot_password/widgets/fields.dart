/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/forgot_password/bloc/forgot_password_bloc.dart';

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Entrez votre email',
            labelText: 'Email',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
                borderSide: const BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.5),
            ),
          ),
          validator: (value) =>
          state.isEmailEmpty ? null : 'Un email est requis',
          onChanged: (value) =>
              context.read<ForgotPasswordBloc>().add(
                ForgotPasswordEmailChanged(email: value),
              ),
        );
      },
    );
  }
}
