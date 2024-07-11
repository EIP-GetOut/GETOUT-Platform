/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/default_title.dart';

class DefaultField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final String? title;
  final bool mandatory;
  final bool isPassword;
  final String label;

  DefaultField({
    super.key,
    this.title,
    this.mandatory = true,
    required this.label,
    this.validator,
    this.isPassword = false,
    required this.onChanged,
  });

  final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: defaultTitle(title ?? '', mandatory),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: passwordVisible,
                builder: (context, isVisible, child) {
                  return TextFormField(
                    obscureText: isPassword && !isVisible,
                    style: const TextStyle(fontSize: 17, color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffeaeaea),
                      labelText: label,
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.25)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xffeaeaea)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xffeaeaea)),
                      ),
                      errorMaxLines: 4,
                      errorStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        height: 1.5,
                      ),
                      suffixIcon: isPassword
                          ? IconButton(
                              icon: Icon(
                                isVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                passwordVisible.value = !passwordVisible.value;
                              },
                            )
                          : const SizedBox(height: 0),
                    ),
                    validator: (value) {
                      errorMessage.value = validator?.call(value);
                      return errorMessage.value;
                    },
                    onChanged: (value) {
                      errorMessage.value = validator?.call(value);
                      onChanged(value);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
