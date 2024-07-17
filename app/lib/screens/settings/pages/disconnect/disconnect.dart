/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/bloc/user/user_bloc.dart';

import 'package:getout/tools/app_l10n.dart';
import 'package:getout/screens/settings/services/service.dart';

void showAlertDialog(BuildContext context) {
  print('>a');
  final UserState userState = context.read<UserBloc>().state;
  print('b');
  final SettingService service = SettingService(userState.cookiePath, userState.account!.id);

  Widget cancelButton = TextButton(
    child: const Text('Annuler'),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
      child: const Text('Se déconnecter'),
      onPressed: () async {
        try {
          await service.disconnect();
          if (context.mounted) {
            context.read<UserBloc>().add(const DisconnectEvent());
            Navigator.pop(context);
            Navigator.pop(context);
          }
        } catch (e) {
          // print(e);
        }
      });

  AlertDialog alert = AlertDialog(
    title: const Text('Déconnexion'),
    content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
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

class DisconnectPage extends StatelessWidget {
  const DisconnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.06,
        color: const Color.fromRGBO(255, 82, 65, 0.4),
        child: InkWell(
            onTap: () {
              print('a');
              return showAlertDialog(context);
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.exit_to_app_outlined),
                  Text(
                    appL10n(context)!.disconnect,
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
