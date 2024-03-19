/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

double widthFactor(final BuildContext context, final double factor)
{
  if (factor >= 1 || factor <= 0) {
    return MediaQuery.of(context).size.width;
  }
  return MediaQuery.of(context).size.width * factor;
}

double heightFactor(final  BuildContext context, final double factor)
{
  if (factor >= 1 || factor <= 0) {
    return MediaQuery.of(context).size.height;
  }
  return MediaQuery.of(context).size.height * factor;
}
