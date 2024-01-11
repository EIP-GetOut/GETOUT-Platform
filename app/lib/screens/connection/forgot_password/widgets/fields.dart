/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/forgot_password/children/check_email/bloc/check_email_bloc.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<CheckEmailBloc, CheckEmailState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Entrez votre adresse email',
            floatingLabelBehavior: FloatingLabelBehavior.never,
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
              context.read<CheckEmailBloc>().add(
                ForgotPasswordEmailChanged(email: value),
              ),
        );
      },
    );
  }
}

class CodeField extends StatelessWidget {
  const CodeField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
          obscureText: true,
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
              labelText: 'Entrez le code',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isCodeValid ? null : 'un code requis',
          onChanged: (value) => context.read<NewPasswordBloc>().add(
            ForgotPasswordCodeChanged(code: value),
          ),
        ),
      );
    });
  }
}


class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
          obscureText: true,
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
              labelText: 'Entrez votre mot de passe',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isPasswordValid ? null : 'Un mot de passe contenant au moins 8 caractères est requis, avec au moins une majuscule, une minuscule et un chiffre est requis',
          onChanged: (value) => context.read<NewPasswordBloc>().add(
            ForgotPasswordPasswordChanged(password: value),
          ),
        ),
      );
    });
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
          obscureText: true,
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
              labelText: 'Confirmez votre mot de passe',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          //(state.password == value) ? null : 'hmmmm',
          state.isConfirmPasswordValid ? null : 'Le mot de passe est différent',
          onChanged: (value) => context.read<NewPasswordBloc>().add(
            ForgotPasswordConfirmPasswordChanged(confirmPassword: value),
          ),
        ),
      );
    });
  }
}
