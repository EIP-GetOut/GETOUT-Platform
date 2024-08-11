/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getout/screens/settings/settings.dart';

import 'package:getout/global.dart' as globals;
import 'package:getout/tools/app_l10n.dart';

import 'package:getout/tools/duration_format.dart';

class HomeAppBarWidget extends AppBar {
  HomeAppBarWidget({super.key, required BuildContext context})
      : super(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          toolbarHeight: 100,
          titleSpacing: 5,
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appL10n(context)!.homepage_title,
                  style: Theme.of(context).textTheme.titleLarge),
              Text(appL10n(context)!.homepage_subtitle,
                  style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(1),
                child: IconButton(
                    icon: const Icon(Icons.settings),
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
