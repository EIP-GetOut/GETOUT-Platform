/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:getout/screens/settings/services/service.dart';
import 'package:getout/bloc/session/session_event.dart';
import 'package:getout/bloc/session/session_bloc.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/tools.dart';

void showAlertDialog(BuildContext context) {
  final SettingService service = SettingService();

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
            context.read<SessionBloc>().add(const DisconnectRequest());
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
        //color: const Color.fromRGBO(255, 82, 65, 0.3),
        child: InkWell(
            onTap: () {
              return showAlertDialog(context);
            },
            child: Padding( padding : const EdgeInsets.only(right: 15.0, left: 15.0), child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/icon/disconnect.svg'),
                  SizedBox(width: Tools.widthFactor(context, 0.065)),
                  Text(
                    appL10n(context)!.disconnect,
                    style: TextStyle(
                        fontSize:
                            (MediaQuery.of(context).size.width > 400) ? 18 : 12,
                        color: const Color.fromRGBO(236, 0, 0, 1.0)),
                  ),
                  const Expanded(child: SizedBox()),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ]))));
  }
}
