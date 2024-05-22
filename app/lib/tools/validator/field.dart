/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/cupertino.dart';
import 'package:getout/tools/app_l10n.dart';

String? mandatoryValidator(BuildContext context, String? field) {
  if (field == null || field == '') {
    return appL10n(context)!.mandatory_validator;
  }
  return null;
}