/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:getout/screens/connection/register/bloc/register_bloc.dart';

class LastNameField extends StatelessWidget {
  const LastNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
              labelText: 'Entrez votre nom',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isLastNameEmpty ? null : 'Un nom est requis',
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterLastNameChanged(lastName: value),
          ),
        ),
      );
    });
  }
}


class FirstNameField extends StatelessWidget {
  const FirstNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return SizedBox(
        height: 50,
        child: TextFormField(
          style: const TextStyle(fontSize: 17, color: Colors.black),
          decoration: InputDecoration(
              labelText: 'Entrez votre prénom',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.5),
                  borderSide: const BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              )),
          validator: (value) =>
          state.isFirstNameEmpty ? null : 'Un prénom est requis',
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterFirstNameChanged(firstName: value),
          ),
        ),
      );
    });
  }
}


class BornDateField extends StatelessWidget {
  BornDateField({Key? key}) : super(key: key);
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
                labelText: 'Sélectionnez votre date de naissance',
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
                return 'Une date est requise';
              }
              return null;
            },
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  locale: const Locale('fr', 'FR'),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                controller.text = formattedDate;
                // ignore: use_build_context_synchronously
                context.read<RegisterBloc>().add(
                  RegisterBornDateChanged(bornDate: formattedDate),
                );
              }
            }
        ),
      );
    });
  }
}


class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

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
            state.isEmailValid ? null : 'Un email valide est requis',
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
  const PasswordField({Key? key}) : super(key: key);

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
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterPasswordChanged(password: value),
          ),
        ),
      );
    });
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({Key? key}) : super(key: key);

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
          onChanged: (value) => context.read<RegisterBloc>().add(
            RegisterConfirmPasswordChanged(confirmPassword: value),
          ),
        ),
      );
    });
  }
}

