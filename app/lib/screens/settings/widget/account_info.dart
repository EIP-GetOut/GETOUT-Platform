/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/global.dart' as globals;

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.15,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //icons with color ?
            Icon(Icons.face, size: MediaQuery.of(context).size.height * 0.12),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${globals.session?['firstName']} ${globals.session?['lastName']}'.toLowerCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width > 400)
                              ? 30
                              : 16,
                          color: Colors.black87)),
                  Text(globals.session?['email'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width > 400)
                              ? 20
                              : 12,
                          color: Colors.black87)),
                ]),
        ]));
  }
}
