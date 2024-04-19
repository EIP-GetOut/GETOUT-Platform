/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppL10n {
  static AppLocalizations? of(BuildContext context) {
    return AppLocalizations.of(context);
  }

  static String ofCallback(BuildContext context, String Function(AppLocalizations? appLocalizations) func) {
    return func(of(context));
  }
}

///functions
AppLocalizations? appL10n(BuildContext context) {
  return AppLocalizations.of(context);
}

String appL10nCallback(BuildContext context, String Function(AppLocalizations? appLocalizations) function) {
  return function(appL10n(context));
}