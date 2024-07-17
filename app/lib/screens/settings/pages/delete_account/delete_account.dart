/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/bloc/user/user_bloc.dart';

import 'package:getout/screens/settings/services/service.dart';
import 'package:getout/tools/app_l10n.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void showAlertDialog(BuildContext context) {
  final UserState userState = context.read<UserBloc>().state;
  final SettingService service = SettingService(userState.cookiePath, userState.account!.id);


  Widget cancelButton = TextButton(
    child: const Text('Annuler'),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
      child: const Text('Supprimer son compte'),
      onPressed: () async {
        try {
          await service.deleteAccount();
          //todo errors
          if (context.mounted) {
            //todo verify this and check success..
            service.disconnect();
            context.read<UserBloc>().add(const DisconnectEvent());
            Navigator.pop(context);
            Navigator.pop(context);
          }
        } catch (e) {
          // print(e);
        }
      });

  AlertDialog alert = AlertDialog(
    title: const Text('Suppression de compte'),
    content: const Text('Êtes-vous sûr de vouloir supprimer votre compte ?'),
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

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.06,
        color: const Color.fromRGBO(255, 82, 65, 0.4),
        child: InkWell(
            onTap: () {
              return showAlertDialog(context);
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.delete_outlined),
                  Text(
                    appL10n(context)!.delete_account,
                    style: TextStyle(
                        fontSize:
                            (MediaQuery.of(context).size.width > 400) ? 20 : 12,
                        color: Colors.black),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ])));
  }
}
