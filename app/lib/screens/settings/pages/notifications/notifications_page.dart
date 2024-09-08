/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';

import 'package:getout/global.dart' as globals;
import 'package:getout/screens/settings/widget/title.dart';
import 'package:getout/tools/app_l10n.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appL10n(context)!.notifications_getout.toUpperCase()),
          leading: const BackButton(),
        ),
        body: Column(children: [
          const SizedBox(height: 50),
          const TitleRow(value: 'Global notification'),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appL10n(context)!.recommendations,
                        style:
                            TextStyle(fontSize: 20, color: Colors.grey[800])),
                    FlutterSwitch(
                      height: 35.0,
                      width: 65.0,
                      padding: 6.0,
                      toggleSize: 20.0,
                      borderRadius: 20.0,
                      value: globals.notificationsServices.isActive,
                      activeColor: const Color.fromRGBO(213, 86, 65, 1),
                      onToggle: (val) {
                        setState(() {
                          globals.notificationsServices.isActive = val;
                        });
                        globals.notificationsServices.isActive = val;
                        if (val == false) {
                          globals.notificationsServices.stopNotif();
                        } else {
                          globals.notificationsServices.sendNotif();
                        }
                      },
                    ),
                  ]))
        ]));
  }
}
