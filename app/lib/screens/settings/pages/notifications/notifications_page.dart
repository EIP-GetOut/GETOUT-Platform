/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:getout/global.dart' as globals;

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
          title: const Text('NOTIFICATIONS'),
          leading: const BackButton(),
        ),
        body: Column(children: [
          const SizedBox(height: 50),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'NOTIFICATIONS PUSH',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recommandations',
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
