/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/settings/bloc/edit_password/edit_password_bloc.dart';
import 'package:getout/tools/app_l10n.dart';

class OldPasswordField extends StatelessWidget {
  const OldPasswordField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: TextFormField(
            obscureText: true,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Entrez votre mot de passe actuel',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            validator: (value) =>
            state.isOldPasswordEmpty ? null : 'Veuillez entrer votre mot de passe actuel',
            onChanged: (value) =>
                context.read<EditPasswordBloc>().add(
                  OldPasswordChanged(oldPassword: value),
                ),
          ),
        );
      },
    );
  }
}

class NewPasswordField extends StatelessWidget {
  const NewPasswordField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
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
            validator: (value) {
              if (!state.isNewPasswordEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              if (!state.isNewPasswordValid) {
                return 'Le mot de passe doit contenir au moins 8 caractères\nune majuscule, un chiffre et un caractère spécial';
              }
              if (!state.isNewPasswordDifferent) {
                return 'Le nouveau mot de passe doit être différent\nde l\'ancien';
              }
              return null;
            },
            onChanged: (value) =>
                context.read<EditPasswordBloc>().add(
                  NewPasswordChanged(newPassword: value),
                ),
          ),
        );
      },
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: TextFormField(
            obscureText: true,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
              labelText: appL10n(context)!.confirm_password_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            validator: (value) =>
            state.isConfirmPasswordGood ? null : 'Les mots de passe ne correspondent pas',
            onChanged: (value) =>
                context.read<EditPasswordBloc>().add(
                  ConfirmPasswordChanged(confirmPassword: value),
                ),
          ),
        );
      },
    );
  }
}