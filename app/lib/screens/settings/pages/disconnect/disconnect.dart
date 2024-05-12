/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/bloc/session/session_bloc.dart';

import 'package:getout/global.dart' as globals;

import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:getout/constants/http_status.dart';
import 'package:getout/screens/connection/login/bloc/login_bloc.dart';
import 'package:getout/screens/settings/services/service.dart';
import 'package:getout/screens/connection/login/pages/login.dart';
import 'package:getout/bloc/session/session_event.dart';



void showAlertDialog(BuildContext context) {

    final SettingService service = SettingService();

    Widget cancelButton = TextButton(
      child: const Text("Annuler"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Se déconnecter"),
//         curl --location 'http://localhost:8080/account/logout' \
// --header 'Content-Type: application/json' \
// --data '{
// }'
        // print("disconnect");

        onPressed: () async {
            //todo setup request & error handling, setup validator with tools function;
              try {
                // StatusResponse response =
                //     await service.disconnect();
                // Navigator.pop(context);
                print("RESPONSE = ");
                // print(response.status);
                // BlocProvider.of<LoginBloc>(context)
                //         .add(Logout());

                BlocProvider.of<LoginBloc>(context).add(Logout());
                // if (response.status == HttpStatus.NO_CONTENT) {
                // }

                // if (response.status == HttpStatus.NO_CONTENT) {
                //   print("DISCONNNNNNNNNNNNNNNNNNNECTDBHZEHFZUEGIZU");
                //   // await globals.sessionManager.getSession();
                // }
                //handle response
                
              } catch (e) {
                  print("error");
                  print(e);

                //handle error
              }
            }
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Déconnexion"),
      content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
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