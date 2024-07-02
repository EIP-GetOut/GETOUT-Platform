/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/cupertino.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:intl/intl.dart';

String? firstnameValidator(BuildContext context, String? field) {
  if (field == null || field == '') {
    return appL10n(context)!.firstname_validator;
  }
  return null;
}

String? lastnameValidator(BuildContext context, String? field) {
  if (field == null || field == '') {
    return appL10n(context)!.lastname_validator;
  }
  return null;
}

String? birthdateValidator(BuildContext context, String? field) {
  if (field == null || field.isEmpty) {
    return appL10n(context)!.birthday_validator;
  }
//              DateFormat format = DateFormat('dd/MM/yy');
  DateTime date = DateFormat('dd/MM/yy').parse(field);
  if (date.isAfter(DateTime.now().subtract(const Duration(days: 365 * 13)))) {
    return appL10n(context)!.too_young;
  }
  return null;
}

String? mandatoryValidator(BuildContext context, String? field) {
  if (field == null || field == '') {
    return appL10n(context)!.mandatory_validator;
  }
  return null;
}