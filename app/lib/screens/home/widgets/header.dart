/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getout/screens/settings/pages/settings.dart';

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
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/Profile_picture.png',
                  width: 60,
                )),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bienvenue !',
                  style: Theme.of(context).textTheme.titleLarge),
              Text('La productivité à portée de main',
                  style: Theme.of(context).textTheme.displayMedium)
            ],
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/GetOut_logo.png',
                  width: 40,
                )),
          ],
        );
}