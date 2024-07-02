/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/cupertino.dart';
import 'package:getout/constants/regular_expression.dart';
import 'package:getout/tools/app_l10n.dart';

String? newPasswordValidator(BuildContext context, String? password) {
  RegExp regex = RegExp(RegularExpression.password);

  if (password == null || !regex.hasMatch(password)) {
    return appL10n(context)!.password_validator;
  }
  return null;
}

String? confirmPasswordValidator(
    BuildContext context, String? newPassword, String? confirmPassword) {
  String? result = newPasswordValidator(context, confirmPassword);

  print('confirmValidator "$newPassword", "$confirmPassword"');
  if (result != null) {
    return result;
  }
  return (newPassword != confirmPassword)
      ? appL10n(context)!.password_matching
      : null;
}
