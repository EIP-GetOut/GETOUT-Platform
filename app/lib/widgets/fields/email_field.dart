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
import 'package:getout/screens/connection/forgot_password/children/check_email/bloc/check_email_bloc.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/connection/forgot_password/children/new_password/bloc/new_password_bloc.dart';
import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';

import 'package:getout/tools/app_l10n.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return DefaultField(
        title: 'ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrez votre adresse email',
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
        title: 'ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrez votre adresse email',
        validator: (value) =>
            state.isEmailEmpty ? null : appL10n(context)!.email_validator,
        onChanged: (value) => context.read<CheckEmailBloc>().add(
              ForgotPasswordEmailChanged(email: value),
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
          title: 'MOT DE PASSE',
          mandatory: true,
          label: 'Entrez votre mot de passe',
          validator: (value) => state.isConfirmPasswordValid
              ? null
              : appL10n(context)!.password_matching,
          onChanged: (value) => context.read<NewPasswordBloc>().add(
                ForgotPasswordConfirmPasswordChanged(confirmPassword: value),
              ));
    });
  }
}

class RegisterEmailField extends StatelessWidget {
  const RegisterEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DefaultField(
        title: 'ADRESSE MAIL',
        mandatory: true,
        label: 'Entrez votre adresse mail',
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

  const ConfirmEmailField({super.key, this.validator, required this.onChanged});

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

class EditEmailField extends StatelessWidget {
  const EditEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
        builder: (context, state) {
      return DefaultField(
        title: 'ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrez votre nouvelle adresse email',
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
        title: 'CONFIRMER VOTRE ADRESSE EMAIL',
        mandatory: true,
        label: 'Entrez votre nouvelle adresse email',
        validator: (value) =>
            state.isConfirmEmailGood ? null : 'Les emails ne correspondent pas',
        onChanged: (value) => context.read<EditEmailBloc>().add(
              ConfirmEmailChanged(confirmEmail: value),
            ),
      );
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
        title: 'MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre mot de passe',
        validator: (value) => state.isPasswordEmpty
            ? null
            : 'Le mot de passe ne peut pas être vide',
        onChanged: (value) => context.read<EditEmailBloc>().add(
              PasswordChanged(password: value),
            ),
      );
    });
  }
}
