/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

class ActionString extends StatelessWidget {
  final Function() onTap;
  final String question;
  final String action;

  const ActionString({super.key, required this.onTap, required this.question, required this.action});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,/*() { //todo
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return RegisterPage(service: service);
          }));
        },*/
        child: Text.rich(
          TextSpan(
            text: question, //todo appL10n(context)!.first_connection,
            style: const TextStyle(color: Colors.black, fontSize: 16),
            children: <InlineSpan>[
              TextSpan(
                text: action, //todo appL10n(context)!.create_account,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(213, 86, 65, 0.992)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
