/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String continueText, String label,
    String content, Function() onPressed) {
  Widget cancelButton = TextButton(
    child: const Text('Annuler'),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton =
      TextButton(child: Text(continueText), onPressed: () async => onPressed());

  AlertDialog alert = AlertDialog(
    title: Text(label),
    content: Text(content),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
