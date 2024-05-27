/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';
import 'package:getout/tools/app_l10n.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: TextFormField(
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
              labelText: appL10n(context)!.email_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            validator: (value) {
              if (!state.isEmailEmpty) {
                return 'L\'email ne peut pas être vide';
              } else if (!state.isEmailValid) {
                return 'L\'email n\'est pas valide';
              } else if (!state.isNewEmailDifferent) {
                return 'L\'email doit être différent de l\'ancien email';
              } else {
                return null;
              }
            },
            onChanged: (value) =>
                context.read<EditEmailBloc>().add(
                  EmailChanged(email: value),
                ),
          ),
        );
      },
    );
  }
}

class ConfirmEmailField extends StatelessWidget {
  const ConfirmEmailField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: TextFormField(
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
              labelText: appL10n(context)!.email_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            validator: (value) =>
            state.isConfirmEmailGood ? null : 'Les emails ne correspondent pas',
            onChanged: (value) =>
                context.read<EditEmailBloc>().add(
                  ConfirmEmailChanged(confirmEmail: value),
                ),
          ),
        );
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: TextFormField(
            obscureText: true,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
              labelText: appL10n(context)!.password_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            validator: (value) =>
            state.isPasswordEmpty ? null : 'Le mot de passe ne peut pas être vide',
            onChanged: (value) =>
                context.read<EditEmailBloc>().add(
                  PasswordChanged(password: value),
                ),
          ),
        );
      },
    );
  }
}