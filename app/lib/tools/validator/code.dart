/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/cupertino.dart';
import 'package:getout/constants/regular_expression.dart';
import 'package:getout/tools/app_l10n.dart';

String? codeValidator(BuildContext context, String? code) {
  RegExp regex = RegExp(RegularExpression.code);

  if (code == null || !regex.hasMatch(code)) {
    return appL10n(context)?.code_validator;
  }
  return null;
}