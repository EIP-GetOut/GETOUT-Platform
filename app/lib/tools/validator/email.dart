/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/cupertino.dart';
import 'package:getout/constants/regular_expression.dart';
import 'package:getout/tools/app_l10n.dart';

String? emailValidator(BuildContext context, String? email) {
  RegExp regex = RegExp(RegularExpression.email);

  if (email == null || !regex.hasMatch(email)) {
    return appL10n(context)?.email_validator;
  }
  return null;
}

String? confirmEmailValidator(BuildContext context, String? newEmail, String? confirmEmail) {
  String? result = emailValidator(context, confirmEmail);

  if (result != null) {
    return result;
  }
  return (newEmail != confirmEmail) ? appL10n(context)?.email_matching : null;
}
