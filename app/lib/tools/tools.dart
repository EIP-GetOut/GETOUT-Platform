/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

part 'screen_size_factor.dart';
part 'auto_sizing_text.dart';

class Tools {
  static const double Function(BuildContext context, double factor) widthFactor = _widthFactor;
  static const double Function(BuildContext context, double factor) heightFactor = _heightFactor;
  const Tools();
}