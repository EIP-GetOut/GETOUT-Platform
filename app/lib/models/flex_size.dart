/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

double perHeight(BuildContext context, int percentage) {
  return percentage * MediaQuery.of(context).size.height / 100;
}

double perWidth(BuildContext context, int percentage) {
  return percentage * MediaQuery.of(context).size.width / 100;
}

double uniHeight(BuildContext context, int percentage, bool isLandscape) {
  if (isLandscape) {
    return percentage * MediaQuery.of(context).size.width / 100;
  } else {
    return percentage * MediaQuery.of(context).size.height / 100;
  }
}

double uniWidth(BuildContext context, int percentage, bool isLandscape) {
  if (isLandscape) {
    return percentage * MediaQuery.of(context).size.height / 100;
  } else {
    return percentage * MediaQuery.of(context).size.width / 100;
  }
}
