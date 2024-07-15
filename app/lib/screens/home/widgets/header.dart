/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getout/screens/settings/settings.dart';
import 'package:getout/tools/app_l10n.dart';

class HomeAppBarWidget extends AppBar {
  HomeAppBarWidget({super.key, required BuildContext context})
      : super(
          /**
           * appBarSettings
           */
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          toolbarHeight: 100,
          titleSpacing: 5,
          backgroundColor: Colors.white,
          /**
           * leading | title | actions
           * -------------------------
           *  Profil | Title |  Quit
           * -------------------------
           */
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 0),
                child: Image.asset(
                  'assets/images/icon/profile_picture.png',
                  width: 60,
                )),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appL10n(context)!.homepage_title,
                  style: Theme.of(context).textTheme.titleLarge),
              Text(appL10n(context)!.homepage_subtitle,
                  style: Theme.of(context).textTheme.displayMedium),
              /*Text( //hold info
                  durationFormat(appL10n(context)!.you_saved,
                      context.watch<UserBloc>().state.account!.spentMinutesReadinAndWatching),
                  style: Theme.of(context).textTheme.bodySmall)*/
            ],
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/logo/getout.png',
                  width: 40,
                )),
          ],
        );
}
