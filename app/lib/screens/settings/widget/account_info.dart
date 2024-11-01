/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:getout/global.dart' as globals;

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.12,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // icons with color ?
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                AutoSizeText('${globals.session?['firstName']} ${globals.session?['lastName']}'.toLowerCase(),
                maxLines: 2,
                minFontSize: 28.0,
                maxFontSize: 40.0,
                style: TextStyle(
                    color: Theme.of(context).primaryColor)),
                  Text(globals.session?['email'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: (MediaQuery.of(context).size.width > 400)
                              ? 18
                              : 12,
                          color: Colors.black87)),
                ]),
        ]));
  }
}
