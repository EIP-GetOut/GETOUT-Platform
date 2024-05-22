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
import 'package:getout/tools/app_l10n.dart';

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
          state.isEmailEmpty ? null : appL10n(context)!.email_validator,
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
              labelText: appL10n(context)!.code_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isCodeValid ? null : appL10n(context)!.code_validator,
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
              labelText: appL10n(context)!.password_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isPasswordValid ? null : appL10n(context)!.password_validator,
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
              labelText: appL10n(context)!.confirm_password_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isConfirmPasswordValid ? null : appL10n(context)!.password_matching,
          onChanged: (value) => context.read<NewPasswordBloc>().add(
            ForgotPasswordConfirmPasswordChanged(confirmPassword: value),
          ),
        ),
      );
    });
  }
}
