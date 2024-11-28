/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/widgets/fields/email_field.dart';

class NewEmailPage extends StatelessWidget {
  const NewEmailPage({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: const Column(
          children: [
            SizedBox(height: 30),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: EditEmailField()),
          ],
        ),
      ),
    );
  }
}
