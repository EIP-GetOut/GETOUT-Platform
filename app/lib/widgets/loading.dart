/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/tools/tools.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Tools.heightFactor(context, 0.5),
        width: Tools.widthFactor(context, 0.5),
        child: Image.asset('assets/images/logo/getout.png'));
  }
}
