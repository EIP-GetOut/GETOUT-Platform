/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getout/screens/settings/settings.dart';

// import 'package:getout/tools/app_l10n.dart';

class HomeAppBarWidget extends AppBar {
  HomeAppBarWidget({super.key, required BuildContext context, required String title, required String subtitle})
      : super(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          toolbarHeight: 100,
          titleSpacing: 5,
          backgroundColor: Colors.white,
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      // appL10n(context)!.homepage_title
                      child: Text(title,
                          style: Theme.of(context).textTheme.titleLarge)),
                  Padding(
                      // appL10n(context)!.homepage_subtitle
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(subtitle,
                          style: Theme.of(context).textTheme.displayMedium)),
                ])
              ],
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                      icon: const Icon(Icons.settings, size: 40),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsPage()));
                      })),
            ],
        );
}
