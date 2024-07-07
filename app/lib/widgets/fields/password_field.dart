/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/screens/settings/bloc/edit_password/edit_password_bloc.dart';
import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';
import 'package:getout/tools/app_l10n.dart';

class PasswordField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const PasswordField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: appL10n(context)!.password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.password_hint,
        validator: validator,
        onChanged: onChanged);
  }
}

class NewPasswordField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const NewPasswordField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: appL10n(context)!.new_password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.new_password_hint,
        validator: validator,
        onChanged: onChanged);
  }
}

class ConfirmPasswordField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const ConfirmPasswordField(
      {super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: appL10n(context)!.confirm_password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.confirm_password_hint,
        validator: validator,
        onChanged: onChanged);
  }
}

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return DefaultField(
        title: appL10n(context)!.password.toUpperCase(),
        mandatory: true,
        isPassword: true,
        label: appL10n(context)!.password_hint,
        validator: (value) =>
            state.isPasswordEmpty ? null : appL10n(context)!.password_empty,
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }
}

class ForgotPasswordField extends StatelessWidget {
  const ForgotPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
        builder: (context, state) {
      return DefaultField(
          title: appL10n(context)!.new_password.toUpperCase(),
          isPassword: true,
          mandatory: true,
          label: appL10n(context)!.new_password_hint,
          validator: (value) => state.isPasswordValid
              ? null
              : appL10n(context)!.password_validator,
          onChanged: (value) => context.read<NewPasswordBloc>().add(
                ForgotPasswordPasswordChanged(password: value),
              ));
    });
  }
}

class RegisterPasswordField extends StatelessWidget {
  const RegisterPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DefaultField(
        isPassword: true,
        title: appL10n(context)!.password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.password_hint,
        validator: (value) => state.isPasswordValid
            ? null
            : appL10n(context)!.password_validator,
        onChanged: (value) => context.read<RegisterBloc>().add(
              RegisterPasswordChanged(password: value),
            ),
      );
    });
  }
}

class RegisterConfirmPasswordField extends StatelessWidget {
  const RegisterConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DefaultField(
        isPassword: true,
        title: appL10n(context)!.confirm_password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.confirm_password_hint,
        validator: (value) => state.isConfirmPasswordValid
            ? null
            : appL10n(context)!.password_matching,
        onChanged: (value) => context.read<RegisterBloc>().add(
              RegisterConfirmPasswordChanged(confirmPassword: value),
            ),
      );
    });
  }
}

class EditOldPasswordField extends StatelessWidget {
  const EditOldPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
        builder: (context, state) {
      return DefaultField(
        isPassword: true,
        title: appL10n(context)!.password_actual.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.password_actual_hint,
        validator: (value) => state.isOldPasswordEmpty
            ? null
            : appL10n(context)!.password_actual_empty,
        onChanged: (value) => context.read<EditPasswordBloc>().add(
              OldPasswordChanged(oldPassword: value),
            ),
      );
    });
  }
}

class EditNewPasswordField extends StatelessWidget {
  const EditNewPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
        builder: (context, state) {
      return DefaultField(
        isPassword: true,
        title: appL10n(context)!.new_password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.new_password_hint,
        validator: (value) {
          if (!state.isNewPasswordEmpty) {
            return appL10n(context)!.password_empty;
          }
          if (!state.isNewPasswordValid) {
            return appL10n(context)!.password_validator;
          }
          if (!state.isNewPasswordDifferent) {
            return appL10n(context)!.password_old;
          }
          return null;
        },
        onChanged: (value) => context.read<EditPasswordBloc>().add(
              NewPasswordChanged(newPassword: value),
            ),
      );
    });
  }
}

class EditConfirmPasswordField extends StatelessWidget {
  const EditConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditPasswordBloc, EditPasswordState>(
        builder: (context, state) {
      return DefaultField(
        isPassword: true,
        title: appL10n(context)!.confirm_password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.new_password_hint,
        validator: (value) => state.isConfirmPasswordGood
            ? null
            : appL10n(context)!.password_matching,
        onChanged: (value) => context.read<EditPasswordBloc>().add(
              ConfirmPasswordChanged(confirmPassword: value),
            ),
      );
    });
  }
}

class ForgotPasswordConfirmField extends StatelessWidget {
  const ForgotPasswordConfirmField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
        builder: (context, state) {
      return DefaultField(
          title: appL10n(context)!.confirm_password.toUpperCase(),
          isPassword: true,
          mandatory: true,
          label: appL10n(context)!.confirm_password_hint,
          validator: (value) => state.isConfirmPasswordValid
              ? null
              : appL10n(context)!.password_matching,
          onChanged: (value) => context.read<NewPasswordBloc>().add(
                ForgotPasswordConfirmPasswordChanged(confirmPassword: value),
              ));
    });
  }
}

class EditPasswordField extends StatelessWidget {
  const EditPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
        builder: (context, state) {
      return DefaultField(
        title: appL10n(context)!.password.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.password_hint,
        validator: (value) => state.isPasswordEmpty
            ? null
            : appL10n(context)!.password_empty,
        onChanged: (value) => context.read<EditEmailBloc>().add(
              PasswordChanged(password: value),
            ),
      );
    });
  }
}