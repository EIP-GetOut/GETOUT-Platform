/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:intl/intl.dart';

import 'package:getout/screens/connection/register/bloc/register_bloc.dart';

class LastNameField extends StatelessWidget {
  const LastNameField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
              labelText: appL10n(context)!.lastname_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isLastNameEmpty ? null : appL10n(context)!.lastname_validator,
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterLastNameChanged(lastName: value),
          ),
        ),
      );
    });
  }
}


class FirstNameField extends StatelessWidget {
  const FirstNameField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
              labelText: appL10n(context)!.firstname_hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isFirstNameEmpty ? null : appL10n(context)!.firstname_validator,
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterFirstNameChanged(firstName: value),
          ),
        ),
      );
    });
  }
}


class BirthDateField extends StatelessWidget {
  BirthDateField({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
                labelText: appL10n(context)!.birthday_hint,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.5),
                    borderSide: const BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                )),
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return appL10n(context)!.birthday_validator;
              }
              DateFormat format = DateFormat('dd/MM/yy');
              DateTime date = format.parse(value);
              if (date.isAfter(DateTime.now().subtract(const Duration(days: 365 * 13)))) {
                return appL10n(context)!.too_young;
              }
              context.read<RegisterBloc>().add(
                RegisterBirthDateChanged(birthDate: value),
              );
              return null;
            },
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  locale: const Locale('fr', 'FR'),
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365 * 150)),
                  lastDate: DateTime.now());

              if (pickedDate != null) {
                String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                controller.text = formattedDate;
              }
            }
        ),
      );
    });
  }
}


class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<RegisterBloc, RegisterState>(
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
            state.isEmailValid ? null : appL10n(context)!.email_validator,
            onChanged: (value) =>
                context.read<RegisterBloc>().add(
                  RegisterEmailChanged(email: value),
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
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
            state.isPasswordValid ? null : 'Un mot de passe contenant au moins 8 caractères est requis, avec au moins une majuscule, une minuscule et un chiffre est requis',
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterPasswordChanged(password: value),
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
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
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
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterConfirmPasswordChanged(confirmPassword: value),
          ),
        ),
      );
    });
  }
}
