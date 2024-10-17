/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:getout/global.dart' as globals;
import 'package:getout/tools/tools.dart';
// import 'package:getout/tools/app_l10n.dart';

class NotificationsPage extends StatefulWidget {
  final String value;
  const NotificationsPage({required this.value, super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Padding( padding : const EdgeInsets.only(right: 15.0, left: 15.0), child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/icon/bell(notification).svg'),
                    SizedBox(width: Tools.widthFactor(context, 0.065)),
                    Text(widget.value,
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[800])),
                    const Expanded(child: SizedBox()),
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
                  ])))
        ]);
  }
}
