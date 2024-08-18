/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/global.dart' as globals;
import 'package:getout/tools/duration_format.dart';

import 'package:getout/tools/app_l10n.dart';

import 'dart:math';

class RefreshTimeCard extends StatelessWidget {
  const RefreshTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.access_time_filled,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              title: Text(
                  durationFormatSeconds(appL10n(context)!.refresh, min(globals.session?['secondsBeforeNextMovieRecommendation'], globals.session?['secondsBeforeNextBookRecommendation'])),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
