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
import 'package:getout/screens/connection/register/bloc/register_bloc.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/screens/settings/bloc/edit_password/edit_password_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/screens/settings/bloc/edit_email/edit_email_bloc.dart';

class PasswordField extends StatelessWidget {
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const PasswordField({super.key, this.validator, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DefaultField(
        title: 'MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre mot de passe',
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
        title: 'NOUVEAU MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre nouveau mot de passe',
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
        title: 'CONFIRMATION DE MOT DE PASSE',
        mandatory: true,
        label: 'Confirmer votre mot de passe',
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
        title: 'MOT DE PASSE',
        mandatory: true,
        isPassword: true,
        label: 'Entrez votre mot de passe',
        validator: (value) =>
            state.isPasswordEmpty ? null : appL10n(context)!.password_validator,
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
          title: 'MOT DE PASSE',
          mandatory: true,
          label: 'Entrez votre mot de passe',
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
        title: 'MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre mot de passe',
        validator: (value) => state.isPasswordValid
            ? null
            : 'Un mot de passe contenant au moins 8 caractères est requis, avec au moins une majuscule, une minuscule et un chiffre est requis',
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
        title: 'CONFIRMATION DE MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre mot de passe',
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
        title: 'MOT DE PASSE ACTUEL',
        mandatory: true,
        label: 'Entrez votre mot de passe actuel',
        validator: (value) => state.isOldPasswordEmpty
            ? null
            : 'Veuillez entrer votre mot de passe actuel',
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
        title: 'NOUVEAU MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre nouveau mot de passe',
        validator: (value) {
          if (!state.isNewPasswordEmpty) {
            return 'Veuillez entrer un mot de passe';
          }
          if (!state.isNewPasswordValid) {
            return 'Le mot de passe doit contenir au moins 8 caractères une majuscule, un chiffre et un caractère spécial';
          }
          if (!state.isNewPasswordDifferent) {
            return 'Le nouveau mot de passe doit être différent de l\'ancien';
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
        title: 'CONFIRMER LE MOT DE PASSE',
        mandatory: true,
        label: 'Entrez votre nouveau mot de passe',
        validator: (value) => state.isConfirmPasswordGood
            ? null
            : 'Les mots de passe ne correspondent pas',
        onChanged: (value) => context.read<EditPasswordBloc>().add(
              ConfirmPasswordChanged(confirmPassword: value),
            ),
      );
    });
  }
}

class EditEmailField extends StatelessWidget {
  const EditEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
      return DefaultField(
        isPassword: true,
        title: 'ADRESSE MAIL',
        mandatory: true,
        label: 'Entrez votre nouveau mail',
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
      );
    });
  }
}
