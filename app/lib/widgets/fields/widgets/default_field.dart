/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/widgets/fields/widgets/title_field.dart';

class DefaultField extends StatefulWidget {
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final String? title;
  final bool mandatory;
  final bool isPassword;
  final String label;

  const DefaultField({
    super.key,
    this.title,
    this.mandatory = true,
    required this.label,
    this.validator,
    this.isPassword = false,
    required this.onChanged,
  });

  @override
  State<DefaultField> createState() => _DefaultFieldState();
}

class _DefaultFieldState extends State<DefaultField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //title
      if (widget.title != null)
        fieldTitle(widget.title ?? '', widget.mandatory),
      //field
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SizedBox(
          height: 64,
          child: TextFormField(
            obscureText: widget.isPassword && !passwordVisible,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffeaeaea),
              labelText: widget.label,
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
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            validator: widget.validator,
            onChanged: (value) => widget.onChanged(value),
          ),
        ),
      ),
    ]);
  }
}
