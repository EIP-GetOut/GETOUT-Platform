/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/tools.dart';
import 'package:getout/global.dart' as globals;

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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            height: Tools.heightFactor(context, 0.06),
            child: Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/icon/bell(notification).svg', width: 33),
                      SizedBox(width: Tools.widthFactor(context, 0.065)),
                      Text(widget.value,
                          style:
                              TextStyle(fontSize:
                              (MediaQuery.of(context).size.width > 400)
                                  ? 18
                                  : 12)),
                      const Expanded(child: SizedBox()),
                      FlutterSwitch(
                        height: 35.0,
                        width: 65.0,
                        padding: 6.0,
                        toggleSize: 20.0,
                        borderRadius: 20.0,
                        value: globals.notificationsServices.isNotificationEnable,
                        activeColor: const Color.fromRGBO(213, 86, 65, 1),
                        onToggle: (val) {
                          setState(() {
                            globals.notificationsServices.isNotificationEnable = val;
                          });
                          globals.notificationsServices.isNotificationEnable = val;
                          globals.notificationsServices.saveEnableNotification();
                          if (val == true) {
                            if (globals.notificationsServices.isNotificationPermit == true) {
                              globals.notificationsServices.scheduleNotification();
                            } else {
                              globals.notificationsServices.requestPermission().then((value) {
                                if (value == null && context.mounted) {
                                  showSnackBar(context,
                                      'Vous devez activer les notifications dans les paramètres de votre téléphone',
                                      color: Colors.red);
                                }
                                globals.notificationsServices
                                    .scheduleNotification();
                              });
                            }
                          } else {
                            globals.notificationsServices.cancelScheduledNotification(0);
                          }
                        },
                      ),
                    ])),
          )
        ]);
  }
}
