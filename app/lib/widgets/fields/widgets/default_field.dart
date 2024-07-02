/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/title_field.dart';

class DefaultField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? title;
  final TextEditingController controller;
  final bool mandatory;
  final String label;
  final bool obscure;
  final String? errorString;

  const DefaultField(
      {super.key,
      this.title,
      this.mandatory = true,
      required this.label,
      this.obscure = false,
      this.validator,
      required this.controller,
      this.errorString,
      String? text});

  @override
  Widget build(BuildContext context) {
    ///https://ux.stackexchange.com/questions/124848/should-you-show-current-state-or-the-state-its-about-to-change-to-for-password
    ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(obscure);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //title
          (title != null)
              ? fieldTitle(title??'', mandatory)
              : const SizedBox(),
          //field
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox(
                height: 64,
                child: ValueListenableBuilder<bool>(
                valueListenable: isPasswordVisible,
                builder: (context, value, child) {
                  print('def $errorString');
                  return TextFormField(
                    controller: controller,
                    obscureText: isPasswordVisible.value,
                    style: const TextStyle(fontSize: 17, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: label,
                      errorText: errorString,
                      errorStyle: const TextStyle(color: Color.fromARGB(255, 213, 86, 65)),
                      suffixIcon: (obscure)
                          ? IconButton(
                              icon: Icon((value) ? Icons.visibility: Icons.visibility_off),
                              onPressed: () { isPasswordVisible.value = !isPasswordVisible.value;})
                          : null,
                      //todo: can be used to avoid duplication (also see hintText instead of label)
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.5),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.5),
                      )),
                    validator: validator,
                  );
                }),
              ))
        ]);
  }

}
