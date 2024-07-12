/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/connection/forgot_password/pages/check_email/bloc/check_email_bloc.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';

import 'package:getout/tools/app_l10n.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return DefaultField(
        title: appL10n(context)!.email.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.email_hint,
        validator: (value) =>
            state.isEmailEmpty ? null : appL10n(context)!.email_validator,
        onChanged: (value) =>
            context.read<LoginBloc>().add(LoginEmailChanged(email: value)),
      );
    });
  }
}

class ForgotPasswordEmailField extends StatelessWidget {
  const ForgotPasswordEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckEmailBloc, CheckEmailState>(
        builder: (context, state) {
      return DefaultField(
        title: appL10n(context)!.email.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.email_hint,
        validator: (value) =>
            state.isEmailEmpty ? null : appL10n(context)!.email_validator,
        onChanged: (value) => context.read<CheckEmailBloc>().add(
              ForgotPasswordEmailChanged(email: value),
            ),
      );
    });
  }
}

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DefaultField(
        title: appL10n(context)!.email.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.email_hint,
        validator: (value) =>
            state.isEmailValid ? null : appL10n(context)!.email_validator,
        onChanged: (value) => context.read<RegisterBloc>().add(
              RegisterEmailChanged(email: value),
            ),
      );
    });
  }
}

class NewEmailField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  const NewEmailField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: appL10n(context)!.new_email.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.new_email_hint,
        validator: validator,
        onChanged: onChanged);
  }
}

class ConfirmEmailField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const ConfirmEmailField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: appL10n(context)!.confirm_email.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.confirm_email_hint,
        validator: validator,
        onChanged: onChanged);
  }
}

class EditEmailField extends StatelessWidget {
  const EditEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
        builder: (context, state) {
      return DefaultField(
        title: appL10n(context)!.new_email.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.new_email_hint,
        validator: (value) {
          if (!state.isEmailEmpty) {
            return appL10n(context)!.email_empty;
          } else if (!state.isEmailValid) {
            return appL10n(context)!.email_validator;
          } else if (!state.isNewEmailDifferent) {
            return appL10n(context)!.email_old;
          } else {
            return null;
          }
        },
        onChanged: (value) => context.read<EditEmailBloc>().add(
              EmailChanged(email: value),
            ),
      );
    });
  }
}

class EditConfirmEmailField extends StatelessWidget {
  const EditConfirmEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
        builder: (context, state) {
      return DefaultField(
        title: appL10n(context)!.confirm_email.toUpperCase(),
        mandatory: true,
        label: appL10n(context)!.confirm_email_hint,
        validator: (value) =>
            state.isConfirmEmailGood ? null : appL10n(context)!.email_matching,
        onChanged: (value) => context.read<EditEmailBloc>().add(
              ConfirmEmailChanged(confirmEmail: value),
            ),
      );
    });
  }
}
