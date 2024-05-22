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
  final Function(String) onChanged;
  final String? title;
  final bool mandatory;
  final String label;

  const DefaultField(
      {super.key,
      this.title,
      this.mandatory = true,
      required this.label,
      this.validator,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
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
                child: TextFormField(
                  obscureText: true,
                  style: const TextStyle(fontSize: 17, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: label,
                      //todo: can be used to avoid duplication (also see hintText instead of label)
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.5),
                          borderSide: const BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.5),
                      )),
                  validator: validator,
                  onChanged: (value) => onChanged(value),
                ),
              ))
        ]);
  }
}
